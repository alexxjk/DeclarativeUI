//
//  ImageElementMaker.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit

open class ImageElementMaker<TImageElement: ImageElementImpl>: ElementMaker<TImageElement> {
    
    private var image: UIImage?
    
    private var contentMode: UIView.ContentMode?
    
    private var tintColor: UIColor?
    
    public override init() { }
    
    public func image(_ image: UIImage?) -> Self {
        self.image = image
        return self
    }
    
    public func contentMode(_ contentMode: UIView.ContentMode) -> Self {
        self.contentMode = contentMode
        return self
    }
    
    public func tintColor(_ tintColor: UIColor?) -> Self {
        self.tintColor = tintColor
        return self
    }
    
    public override func make() -> TImageElement {
        let elemnt = super.make()
        if let image = image {
            elemnt.image = image
        }
        if let contentMode = contentMode {
            elemnt.contentMode = contentMode
        }
        // Image must be set before tintColor
        elemnt.tintColor = tintColor
        return elemnt
    }
}
