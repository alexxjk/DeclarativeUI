//
//  ViewControllerContainerView.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/7/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit

class ViewControllerContainerView: ContainerElementImpl {
    
    public required init() {
        
        super.init()
        translatesAutoresizingMaskIntoConstraints = true
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
