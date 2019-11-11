//
//  Color.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation
import UIKit

public enum Color {
    
    case main
    
    case background
    
    case title
    
    case uiTint

    case text
    
    case secondaryText
    
    case itemContainer
    
    case overlay
    
    public var uiColor: UIColor {
        switch self {
        case .main:
            return UIColor(hex: 0xD6182A)
        case .title:
            return UIColor(hex: 0x222222)
        case .background:
            return .white
        case .uiTint:
            return UIColor(hex: 0xDB3069)
        case .text:
            return UIColor(hex: 0x373737)
        case .secondaryText:
            return UIColor(hex: 0xF7DAE8)
        case .itemContainer:
            return UIColor(hex: 0x666666, alpha: 0.09)
        case .overlay:
            return UIColor(hex: 0x0F080D, alpha: 0.87)
        }
    }
    
    public var cgColor: CGColor {
        return uiColor.cgColor
    }
    
    public func alpha(_ alpha: Float) -> UIColor {
        return self.uiColor.withAlphaComponent(CGFloat(alpha))
    }
}


