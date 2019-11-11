//
//  ContainerElementImpl.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit

open class ContainerElementImpl: ElementView, ContainerElement {
    
    public required init() {
        super.init()
        clipsToBounds =  true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func onAppeared() {
        super.onAppeared()
        children.forEach { $0.onAppeared() }
    }
}
