//
//  RatingScoreElement.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/11/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit


protocol RatingScoreElement: Element {
    
    var doOnValueChanged: ((_ value: Float) -> Void)? { get }
    
    var doOnValueChanging: ((_ value: Float) -> Void)? { get }
    
    var doOnInteractionStarted: (() -> Void)? { get }

}

class RatingScoreElementImpl: ElementView, RatingScoreElement {
    
    private var totalProgress: ProgressElement!
    
    private var currentProgress: ProgressElement!
    
    private let progressBarPadding: Float = 12
    
    private var thumb: Thumb!
    private var thumpLeft: Pin!
    
    private var waypoints: TextElement!
    
    var doOnValueChanged: ((_ value: Float) -> Void)?
    
    var doOnValueChanging: ((_ value: Float) -> Void)?
    
    var doOnInteractionStarted: (() -> Void)?
    
    var doOnInteractionEnded: (() -> Void)?
    
    public required init() {
        super.init()
        preservesSuperviewLayoutMargins = true
        corners = CornerRadius(value: 30, topRight: true, bottomRight: false, bottomLeft: false, topLeft: true)
        
        setupElements()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupElements() {
        totalProgress = addElement {
            ProgressElement.Maker()
                .pin(at: .leading())
                .pin(at: .trailing())
                .pin(at: .top(offset: 32))
        }
        
        currentProgress = addElement {
            ProgressElement.Maker()
                .filled(true)
                .pin(at: .leading(toElement: totalProgress))
                .pin(at: Pin(toElement: totalProgress, type: .centerVerticaly))
        }

        
        thumb = addElement {
            Thumb.Maker()
                .pin(at: Pin(toElement: totalProgress, type: .centerVerticaly))
        }
        thumpLeft = thumb.update(pin: Pin(toElement: totalProgress, type: .centerLeading, offset: 150))
        thumb.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleThumbPan(_:))))
        
        currentProgress.update(pin: Pin(toElement: thumb, type: .trailing))
        
        waypoints = addElement {
            TextElementMaker()
                .textStyleFactory(TextStyleBuilder().font(.accent(size: 14)).color(.main))
                .text("Set your score")
                .pin(at: .top(offset: 64))
                .pin(at: Pin(type: .centerHorizontaly))
        }
    }
    
    @objc private func handleThumbPan(_ gestureRecognizer : UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: self)
        switch gestureRecognizer.state {
        case .began:
            doOnInteractionStarted?()
        case .changed:
            let value = (currentProgress.width - thumb.radius - progressBarPadding) / (totalProgress.width - 2 * progressBarPadding)
            let offset = max(progressBarPadding, min(thumpLeft.offset + Float(translation.x), totalProgress.width - progressBarPadding))
            thumb.update(pin: Pin(toElement: totalProgress, type: .centerLeading, offset: offset))
            doOnValueChanging?(value)
        case .ended:
            let value = (currentProgress.width - thumb.radius - progressBarPadding) / (totalProgress.width - 2 * progressBarPadding)
            print(currentProgress.width)
            doOnValueChanged?(value)
            thumpLeft = thumb.pin(for: .centerLeading)
            doOnInteractionEnded?()
        case .cancelled:
            thumpLeft = thumb.pin(for: .centerLeading)
            doOnInteractionEnded?()
        default:
            break
        }
    }
    
    
    class ProgressElement: ElementView {
        
        required init() {
            super.init()
            corners = CornerRadius(value: 3)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        class Maker: ElementMaker<ProgressElement> {
            
            private var filled: Bool = false
            
            func filled(_ filled: Bool) -> Self {
                self.filled = filled
                return self
            }
            
            override func make() -> RatingScoreElementImpl.ProgressElement {
                let element = super.make()
                element.backgroundColor = filled ? Color.main.uiColor : UIColor(hex: 0xF7DAE8)
                return element
            }
            
            override init() {
                super.init()
                _ = height(6)
            }
        }
    }
    
    class Thumb: ImageElementImpl {
        
        private let heightConstant: Float = 30
        
        required init() {
            super.init()
            heightToSet = heightConstant
            widthToSet = heightConstant
            background = Color.main.uiColor
            contentMode = .center
            corners = CornerRadius(value: heightConstant / 2.0)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        var radius: Float {
            return width / 2.0
        }
        
        class Maker: ImageElementMaker<Thumb> {
            
 
        }
    }
}


