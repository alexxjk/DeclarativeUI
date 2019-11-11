//
//  Formatter.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation

public class Formatter {
    public static func number(_ number: Float, minimumFractionDigits: Int = 0, maximumFractionDigits: Int = 0) -> String? {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.minimumFractionDigits = minimumFractionDigits
        formatter.maximumFractionDigits = maximumFractionDigits
        return formatter.string(from: NSNumber(value: number))
    }
    
    public static func rating(_ rating: Float) -> String {
        guard let formattedRating = number(rating, minimumFractionDigits: 0, maximumFractionDigits: 1) else {
            return ""
        }
        return formattedRating
    }
}

