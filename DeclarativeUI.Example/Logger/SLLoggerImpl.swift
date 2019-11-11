//
//  TYSLLoggerImpl.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation

public class SLLoggerImpl: SLLogger {

    public init() { }

    public func log(entry: SLEntry) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm:ss"
        print("\(dateFormatter.string(from: entry.onDate)): \(entry.message ?? "")")
    }
}

