//
//  ElementView.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit

open class ElementView: UIView, Element {
    
    private var behaviors = [String: Behavior]()
    
    private var animators = [String: UIViewPropertyAnimator]()
    
    public private(set) var children = [Element]()
    
    var contentView: ElementView?
    
    private var opacityOldValue: Float = 1
    public var opacity: Float {
        get {
            return Float(alpha)
        }
        set {
            opacityOldValue = newValue
            alpha = CGFloat(newValue)
        }
    }
    
    public var background: UIColor {
        get {
            return backgroundColor ?? .clear
        }
        set {
            backgroundColor = newValue
        }
    }
    
    public var scaleFactor: ScaleFactor {
        get {
            return ScaleFactor(x: Float(transform.a), y: Float(transform.d))
        }
        set {
            let scale = newValue
            transform = CGAffineTransform.identity.scaledBy(x: CGFloat(scale.x), y: CGFloat(scale.y))
        }
    }
    
    public var pins = Set<Pin>()
    
    public var widthToSet: Float?
    public var width: Float {
        get { return Float(bounds.width) }
    }
    
    public var heightToSet: Float?
    public var height: Float {
        get { return Float(bounds.width) }
    }
    
    public var corners = CornerRadius(value: 0) {
        didSet {
            layer.cornerRadius = CGFloat(corners.value)
            var mask = CACornerMask()
            if corners.value > 0 {
                if corners.topRight {
                    mask.insert(.layerMaxXMinYCorner)
                }
                if corners.bottomRight {
                    mask.insert(.layerMaxXMaxYCorner)
                }
                if corners.bottomLeft {
                    mask.insert(.layerMinXMaxYCorner)
                }
                if corners.topLeft {
                    mask.insert(.layerMinXMinYCorner)
                }
            }
            layer.maskedCorners = mask
        }
    }
    
    required public init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        layoutMargins = .zero
        directionalLayoutMargins = .zero
        backgroundColor = .clear
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    public func attach(_ behavior: Behavior) {
        behaviors[behavior.id] = behavior
        if behavior.trigger == .onAttached {
            triggerBehavior(withId: behavior.id)
        }
    }
    
    public func detach(behaviorWithId id: String) {
        
        defer {
            animators[id] = nil
        }
        
        if let animator = animators[id] {
            animator.stopAnimation(true)
            animator.finishAnimation(at: .current)
        }
    }
    
    public func triggerBehavior(withId id: String) {
        guard let behavior = behaviors[id] else { return }
        switch behavior {
        case let animation as Behavior.Animation:
            trigger(animation)
        case let animation as Behavior.PinAnimation:
            update(pin: animation.pin, animated: true)
        case let animation as Behavior.AppearanceAnimation:
            trigger(animation)
        default:
            fatalError("Unsupported behavior")
        }
        
    }
    
    public func onAppeared() {
        doOnAppeared()
        let appearnceBehaviors = behaviors.filter { $0.value.trigger == .onAppeared }
        appearnceBehaviors.forEach { self.triggerBehavior(withId: $0.value.id) }
    }
    
    public func pin(for type: Pin.`Type`) -> Pin? {
        return pins.first { $0.type == type }
    }
    
    @discardableResult
    public func update(pin: Pin, animated: Bool = false) -> Pin {
       
        if pins.insert(pin).inserted {
            constraint(for: self, and: pin).isActive = true
        } else {
            pins.update(with: pin)
        }

        pins.forEach { pin in
            if let superview = superview, let constraintForPin = superview.constraints.first(where: { constraint -> Bool in
                guard (constraint.firstItem as? UIView) == (self as UIView) else {
                    return false
                }
                switch (constraint.firstAttribute, constraint.secondAttribute, pin.type) {
                case (.top, .top, .top):
                    return true
                case (.trailing, .trailing, .trailing):
                    return true
                case (.bottom, .bottom, .bottom):
                    return true
                case (.leading, .leading, .leading):
                    return true
                case (.centerX, .centerX, .centerHorizontaly):
                    return true
                case (.centerX, .leading, .centerLeading):
                    return true
                default:
                    return false
                }
            }) {
                constraintForPin.constant = invertOffset(for: pin, and: self)
            }
            if animated {
                UIView.animate(withDuration: 0.5, delay: 0.1, options: [], animations: {
                    self.superview?.layoutIfNeeded()
                }, completion: nil)
            } else {
                self.superview?.layoutIfNeeded()
            }
        }
        
        return pin
    }
    
    public func toggleOpacity() {
        if opacity > 0 {
            alpha = 0
        } else {
            alpha = CGFloat(opacityOldValue)
        }
    }
    
    open func doOnAppearing() {
        
    }
    
    open func doOnAppeared() {
        
    }
    
    open func doOnDisappearing() {
        
    }
    
    private func trigger(_ animation: Behavior.AppearanceAnimation) {
        switch animation.type {
        case .slideFromBottom:
            update(pin: .init(type: .bottom, offset: -Float(bounds.size.height)))
            update(pin: .init(type: .bottom), animated: true)
        }
    }
    
    private func trigger(_ animation: Behavior.Animation) {
        let curve = { () -> UIView.AnimationCurve in
            switch animation.curve {
            case .linear:
                return .linear
            case .easeOut:
                return .easeOut
            case .easeIn:
                return .easeIn
            case .easeInOut:
                return .easeInOut
            }
        }()
        let animator = UIViewPropertyAnimator(duration: animation.duration, curve: curve) {
            UIView.setAnimationRepeatCount(animation.isPerpetual ? Float.greatestFiniteMagnitude : 0)
            UIView.setAnimationRepeatAutoreverses(animation.isReversible)
            animation.properties.forEach({ property in
                switch property {
                case .opacity(let toValue):
                    self.alpha = toValue
                case .scale(let toValue):
                    self.transform = CGAffineTransform(scaleX: CGFloat(toValue.x), y: CGFloat(toValue.y))
                }
            })
        }
        animators[animation.id] = animator
        animator.startAnimation(afterDelay: animation.delay)
    }
}


// MARK: - Container

extension ElementView {
    
    @discardableResult
    public func addElement<TElement: Element>(maker: () -> ElementMaker<TElement>) -> TElement {
        let element = maker().make()
        children.append(element)
        if let contentView = contentView {
            contentView.addSubview(element)
        } else {
            addSubview(element)
        }
        setPins(forElment: element)
        return element
    }
    
    private func setPins<TElement: ElementView>(forElment element: TElement) {
        
        if let widthConstant = element.widthToSet {
            element.widthAnchor.constraint(equalToConstant: CGFloat(widthConstant)).isActive = true
        }
        
        if let heightConstant = element.heightToSet {
            element.heightAnchor.constraint(equalToConstant: CGFloat(heightConstant)).isActive = true
        }
        
        NSLayoutConstraint.activate(element.pins.map { constraint(for: element, and: $0) })
    }
    
    private func constraint(for element: ElementView, and pin: Pin) -> NSLayoutConstraint {
        let anchor = anchorElement(for: pin, and: element)
        let anchorElement = anchor.anchrElement
        let layoutGuide = self.layoutGuide(for: pin, and: anchorElement)
        switch pin.type {
        case .centerVerticaly:
            return element.centerYAnchor.constraint(equalTo: anchorElement.centerYAnchor)
        case .centerHorizontaly:
            return element.centerXAnchor.constraint(equalTo: anchorElement.centerXAnchor)
        case .leading:
            return element.leadingAnchor.constraint(
                equalTo: layoutGuide?.leadingAnchor ?? anchorElement.leadingAnchor,
                constant: invertOffset(for: pin, and: element)
            )
        case .trailing:
            return element.trailingAnchor.constraint(
                equalTo: layoutGuide?.trailingAnchor ?? anchorElement.trailingAnchor,
                constant: invertOffset(for: pin, and: element)
            )
        case .bottom:
            return element.bottomAnchor.constraint(
                equalTo: layoutGuide?.bottomAnchor ?? anchorElement.bottomAnchor,
                constant: invertOffset(for: pin, and: element)
            )
        case .top:
            return element.topAnchor.constraint(
                equalTo: layoutGuide?.topAnchor ?? anchorElement.topAnchor,
                constant: invertOffset(for: pin, and: element)
            )
        case .leadingTrailing:
            return element.leadingAnchor.constraint(
                equalTo: anchor.anchrElement.trailingAnchor,
                constant: invertOffset(for: pin, and: element)
            )
        case .trailingLeading:
            return element.trailingAnchor.constraint(
                equalTo: anchor.anchrElement.leadingAnchor,
                constant: invertOffset(for: pin, and: element)
            )
        case .topBottom:
            return element.topAnchor.constraint(
                equalTo: anchor.anchrElement.bottomAnchor,
                constant: invertOffset(for: pin, and: element)
            )
        case .centerLeading:
            return element.centerXAnchor.constraint(
                equalTo: anchor.anchrElement.leadingAnchor,
                constant: invertOffset(for: pin, and: element)
            )
        }
    }
    
    private func layoutGuide(for pin: Pin, and anchorElement: ElementView) -> UILayoutGuide? {
        if !pin.respectingSafeArea && !pin.respectingLayuMargings {
            return nil
        } else if pin.respectingLayuMargings {
            return anchorElement.layoutMarginsGuide
        } else {
            return anchorElement.safeAreaLayoutGuide
        }
    }
    
    private func anchorElement(for pin: Pin, and element: ElementView) -> (anchrElement: ElementView, pinnedToSuperview: Bool) {
        let anchorElement = (pin.toElement as? UIView) ?? element.superview!
        let pinnedToSuperview = anchorElement == element.superview
        return (anchorElement as! ElementView, pinnedToSuperview)
    }
    
    private func invertOffset(for pin: Pin, and element: ElementView) -> CGFloat {
        
        let anchor = anchorElement(for: pin, and: element)
        switch pin.type {
        case .trailing, .bottom:
            return anchor.pinnedToSuperview ? -CGFloat(pin.offset) : CGFloat(pin.offset)
        default:
            return CGFloat(pin.offset)
        }
    }
}

public struct CornerRadius {
    
    public let value: Float
    
    public let topRight: Bool
    
    public let bottomRight: Bool
    
    public let bottomLeft: Bool
    
    public let topLeft: Bool
    
    public init(value: Float, topRight: Bool, bottomRight: Bool, bottomLeft: Bool, topLeft: Bool) {
        self.value = value
        self.topRight = topRight
        self.bottomRight = bottomRight
        self.bottomLeft = bottomLeft
        self.topLeft = topLeft
    }
    
    public init(value: Float) {
        self.init(value: value, topRight: true, bottomRight: true, bottomLeft: true, topLeft: true)
    }
    
    static func zero() -> CornerRadius {
        return CornerRadius(value: 0)
    }
}
