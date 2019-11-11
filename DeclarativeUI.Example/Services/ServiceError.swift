//
//  ServiceError.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation

public enum ServiceError: Error {
    case unkown
}

extension ServiceError: Equatable {
    
}

