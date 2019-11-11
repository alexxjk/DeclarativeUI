//
//  ContainerElement.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit

public protocol ContainerElement: Element {
    
    var corners: CornerRadius { get set }
    
    var children: [Element] { get }
    
    @discardableResult
    func addElement<TElement: Element>(maker: () -> ElementMaker<TElement>) -> TElement
    
}
