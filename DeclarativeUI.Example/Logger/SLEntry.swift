//
//  TYSLEntry.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation

public struct SLEntry {

    public let onDate: Date

    public let type: SLEntryType

    public let message: String?

    public init(onDate: Date, type: SLEntryType, message: String? = nil) {
        self.onDate = onDate
        self.type = type
        self.message = message
    }
}
