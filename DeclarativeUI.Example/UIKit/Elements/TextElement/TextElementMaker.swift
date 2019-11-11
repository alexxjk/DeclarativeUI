//
//  TextElementMaker.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit

final public class TextElementMaker<TTextElement: TextElementImpl>: ElementMaker<TTextElement> {
    
    private var text: String?
    
    private var textStyleFactory: TextStyleBuilder?
    
    public override init() { }
    
    public func text(_ text: String?) -> Self {
        self.text = text
        return self
    }
    
    public func textStyleFactory(_ textStyleFactory: TextStyleBuilder) -> Self {
        self.textStyleFactory = textStyleFactory
        return self
    }
    
    public override func make() -> TTextElement {
        let elemnt = super.make()
        elemnt.text = text
        elemnt.textStyleFactory = textStyleFactory
        return elemnt
    }
}

