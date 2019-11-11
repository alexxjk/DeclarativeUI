//
//  TextElement.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit

public protocol TextElement: Element {
    
    var text: String? { get set }
    
    var textStyleFactory: TextStyleBuilder? { get set }
    
    func updateAttributes(forRange range: NSRange, with attributes: [NSAttributedString.Key : Any])
}

