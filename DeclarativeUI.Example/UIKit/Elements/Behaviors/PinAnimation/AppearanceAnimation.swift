//
//  AppearanceAnimation.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation

public extension Behavior {
    class AppearanceAnimation: Behavior {
        
        public let type: Type
        
        public init(id: String? = nil, type: Type) {
            self.type = type
            super.init(id: id, trigger: .onAppeared)
        }
            
        public enum `Type` {
            case slideFromBottom
        }
    }
}

