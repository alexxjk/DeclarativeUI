//
//  TextElementImpl.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation
import UIKit

open class TextElementImpl: ElementView, TextElement {
    
    private let label = UILabel()
   
    public var text: String? {
        didSet {
            updateText()
        }
    }
    
    public var textStyleFactory: TextStyleBuilder? {
        didSet {
            updateText()
        }
    }
    
    public required init() {
        super.init()
        label.numberOfLines = 0
        setupComponents()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateAttributes(forRange range: NSRange, with attributes: [NSAttributedString.Key : Any]) {
        guard let text = text, let builder = textStyleFactory else { return }
        let attributedString = builder.makeMutable(text: text)
        attributedString.setAttributes(attributes, range: range)
        label.attributedText = attributedString
    }
    
    private func setupComponents() {
        func setupLabel() {
            label.translatesAutoresizingMaskIntoConstraints = false
            addSubview(label)
            let constraints = [
                label.topAnchor.constraint(equalTo: topAnchor),
                label.rightAnchor.constraint(equalTo: rightAnchor),
                label.bottomAnchor.constraint(equalTo: bottomAnchor),
                label.leftAnchor.constraint(equalTo: leftAnchor)
            ]
            NSLayoutConstraint.activate(constraints)
        }
        
        setupLabel()
    }
    
    private func updateText() {
        guard let text = text else {
            label.text = nil
            return
        }
        
        if let textStyleFactory = textStyleFactory {
            label.attributedText = textStyleFactory.make(text: text)
        } else {
            label.text = text
        }
    }
}
