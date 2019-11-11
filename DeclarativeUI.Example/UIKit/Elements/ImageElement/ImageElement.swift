//
//  ImageElement.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit

public protocol ImageElement: Element {
    
    var image: UIImage? { get set }
    
    var contentMode: UIView.ContentMode { get set }
    
    var tintColor: UIColor? { get set }
}
