//
//  PinAnimation.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation

public extension Behavior {
    class PinAnimation: Behavior {
        
        public let pin: Pin
        
        public init(
            id: String? = nil,
            trigger: Behavior.Trigger = .manually,
            pin: Pin
        ) {
            self.pin = pin
            super.init(id: id, trigger: trigger)
        }
    
    }
}
