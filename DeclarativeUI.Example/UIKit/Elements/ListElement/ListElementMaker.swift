//
//  ListElementMaker.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit

final public class ListElementMaker<TItem, TItemElement, TListElement: ListElementImpl<TItem, TItemElement>>: ElementMaker<TListElement> {
    
    public override init() { }
    
    public override func make() -> TListElement {
        let elemnt = super.make()
        return elemnt
    }
}
