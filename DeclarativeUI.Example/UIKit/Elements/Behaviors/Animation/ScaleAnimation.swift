//
//  ScaleAnimation.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation

public extension Behavior {
    final class ScaleAnimation: Animation {
        
        public init(
            id: String? = nil,
            trigger: Behavior.Trigger = .manually,
            scaleFactor: ScaleFactor,
            isPerpetual: Bool = false,
            isReversed: Bool = false,
            duration: TimeInterval,
            delay: TimeInterval = 0,
            curve: Curve = .easeInOut
        ) {
            
            super.init(
                id: id,
                trigger: trigger,
                properties: [.scale(to: scaleFactor)],
                isPerpetual: isPerpetual,
                isReversed: isReversed,
                duration: duration,
                delay: delay,
                curve: curve
            )
        }
        
    }
}

