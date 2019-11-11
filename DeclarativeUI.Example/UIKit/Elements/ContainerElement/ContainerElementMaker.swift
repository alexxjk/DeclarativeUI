//
//  ContainerElementMaker.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit

open class ContainerElementMaker<TContainerElement: ContainerElementImpl>: ElementMaker<TContainerElement> {
    
    private var corners: CornerRadius = .zero()
    
    private var isRounded: Bool = false
    
    public func corners(_ corners: CornerRadius) -> Self {
        self.corners = corners
        return self
    }
    
    public func rounded() -> Self {
        self.isRounded = true
        return self
    }
    
    public override init() { }
    
    public override func make() -> TContainerElement {
        let elemnt = super.make()
        if let widthConstant = widthConstant, isRounded {
            elemnt.corners = CornerRadius(value: widthConstant / 2.0)
        } else {
            elemnt.corners = corners
        }
        return elemnt
    }
}
