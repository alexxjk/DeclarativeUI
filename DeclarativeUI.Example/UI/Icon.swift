//
//  Icon.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/10/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation
import UIKit

enum Icon: String {
    
    case movie = "movie"
    
    case menu = "menu"

}

extension Icon {
    var image: UIImage? { return UIImage(named: rawValue) }
}
