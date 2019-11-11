//
//  TYSLLogger.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation

public protocol SLLogger: class {
    func log(entry: SLEntry)
}
