//
//  Font.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation
import UIKit

public enum Font {
    
    case title(size: CGFloat)
    
    case ui(size: CGFloat)
    
    case accent(size: CGFloat)
    
    case dominant(size: CGFloat)
    
    public var uiFont: UIFont {
        switch self {
        case .title(let size):
            return UIFont.systemFont(ofSize: size, weight: .semibold)
        case .ui(let size):
            return UIFont.systemFont(ofSize: size, weight: .regular)
        case .accent(let size):
            return UIFont.systemFont(ofSize: size, weight: .medium)
        case .dominant(let size):
            return UIFont.systemFont(ofSize: size, weight: .bold)
        }
    }
    
}
