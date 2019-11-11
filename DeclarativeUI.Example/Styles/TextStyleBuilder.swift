//
//  TextStyleBuilder.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation
import UIKit

final public class TextStyleBuilder {
    
    public init() { }

    public private(set) var font = Font.title(size: 12)

    public private(set) var color = Color.text

    public private(set) var line: CGFloat?

    public private(set) var character: CGFloat?
    
    public func font(_ font: Font) -> TextStyleBuilder {
        self.font = font
        return self
    }
    
    public func color(_ color: Color) -> TextStyleBuilder {
        self.color = color
        return self
    }
    
    public func line(_ line: CGFloat) -> TextStyleBuilder {
        self.line = line
        return self
    }
    
    public func character(_ character: CGFloat) -> TextStyleBuilder {
        self.character = character
        return self
    }
    
    public func make(text: String) -> NSAttributedString {
        let attributes = makeAttributes()
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    public func makeMutable(text: String) -> NSMutableAttributedString {
        let attributes = makeAttributes()
        return NSMutableAttributedString(string: text, attributes: attributes)
    }
    
    public func makeAttributes() -> [NSAttributedString.Key: Any] {
        var attributes = [NSAttributedString.Key: Any]()
        let paragraphStyle = NSMutableParagraphStyle()
        if let line = line {
            paragraphStyle.minimumLineHeight = line
            paragraphStyle.maximumLineHeight = line
        }
        attributes[.foregroundColor] = self.color.uiColor
        attributes[.paragraphStyle] = paragraphStyle
        if let character = character {
            attributes[.kern] = character
        }
        attributes[.font] = font.uiFont
        return attributes
    }
}
