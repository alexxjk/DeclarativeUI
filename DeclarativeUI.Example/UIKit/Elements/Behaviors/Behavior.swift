//
//  Behavior.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation
import UIKit

public class Behavior {
    
    public let id: String
    
    public let trigger: Trigger
    
    public init(id: String?, trigger: Trigger) {
        self.id = id ?? UUID().uuidString
        self.trigger = trigger
    }
    
    public enum Trigger {
        case manually
        case onAttached
        case onAppeared
    }
    
    public static func create(from descriptor: Descriptor, withId id: String? = nil, triggerOn trigger: Trigger = .onAttached) -> Behavior {
        switch descriptor {
        case .animation(let properties, let duration):
            return Animation(id: id, trigger: trigger, properties: properties, duration: duration)
        case .scale(let scaleFactor, let duration):
            return ScaleAnimation(id: id, trigger: trigger, scaleFactor: scaleFactor, duration: duration)
        case .opacity(let toValue, let duration):
            return OpacityAnimation(id: id, trigger: trigger, toValue: toValue, duration: duration)
        }
    }
    
    public enum Descriptor {
        
        case animation(properties: [AnimationProperty], duration: TimeInterval)
        
        case scale(scaleFactor: ScaleFactor, duration: TimeInterval)
        
        case opacity(toValue: CGFloat, duration: TimeInterval)
    
    }
}

