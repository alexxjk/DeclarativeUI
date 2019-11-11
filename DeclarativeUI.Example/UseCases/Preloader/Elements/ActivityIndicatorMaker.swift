//
//  ActivityIndicatorMaker.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/9/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit

final class ActivityIndicatorMaker: ElementMaker<ActivityIndicator> {
    
    override init() {
        super.init()
    }
    
    override func make() -> ActivityIndicator {
        let element = super.make()
        element.image = UIImage(named: "preloader_logo")
        element.contentMode = .scaleAspectFit
        element.widthAnchor.constraint(equalToConstant: 103).isActive = true
        element.heightAnchor.constraint(equalToConstant: 130).isActive = true
        return element
    }
}
