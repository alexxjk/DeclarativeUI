//
//  ElementMaker.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit

open class ElementMaker<TElement: ElementView & Element> {
    
    private var opacity: Float = 1
    
    private var scale: ScaleFactor = .one
    
    var widthConstant: Float?
    
    var heightConstant: Float?
    
    private var backgroundColor: UIColor?
    
    private var corners: CornerRadius?
    
    private var behaviors = [Behavior]()
    
    private var pin = Set<Pin>()
    
    public init() { }
    
    public func opacity(_ alpha: Float) -> Self {
        self.opacity = alpha
        return self
    }
    
    public func scale(_ scale: ScaleFactor) -> Self {
        self.scale = scale
        return self
    }
    
    public func width(_ widthConstant: Float) -> Self {
        self.widthConstant = widthConstant
        return self
    }
    
    public func height(_ heightConstant: Float) -> Self {
        self.heightConstant = heightConstant
        return self
    }
    
    public func background(_ color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }
    
    public func background(_ color: Color) -> Self {
        self.backgroundColor = color.uiColor
        return self
    }
    
    public func pin(toElement element: Element? = nil) -> Self {
        self.pin.update(with: Pin(toElement: element, type: .centerHorizontaly))
        self.pin.update(with: Pin(toElement: element, type: .centerVerticaly))
        return self
    }
    
    public func pin(at pin: Pin) -> Self {
        self.pin.update(with: pin)
        return self
    }
    
    public func behavior(_ behavior: Behavior) -> Self {
        self.behaviors.append(behavior)
        return self
    }
    
    public func on(_ trigger: Behavior.Trigger, _ descriptor: Behavior.Descriptor) -> Self {
        let behaviorToAttach = Behavior.create(from: descriptor, triggerOn: trigger)
        return behavior(behaviorToAttach)
    }
    
    open func make() -> TElement {
        
        let element = TElement()

        element.translatesAutoresizingMaskIntoConstraints = false
        
        element.opacity = opacity
        
        element.scaleFactor = scale
        
        if let widthConstant = widthConstant {
            element.widthToSet = widthConstant
        }
        
        if let heightConstant = heightConstant {
            element.heightToSet = heightConstant
        }
        
        element.pins = pin
        
        if let backgroundColor = backgroundColor {
            element.backgroundColor = backgroundColor
        }
        
        if let corners = corners {
            element.corners = corners
        }
        
        behaviors.forEach {
            element.attach($0)
        }
        
        return element
    }
}

