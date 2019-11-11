//
//  Movie.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation

struct Movie {
    
    let imdbId: String
    
    let title: String
    
    let genre: String
    
    let rating: Float
    
    let summary: String?
    
    init(
        imdbId: String,
        title: String,
        genre: String,
        rating: Float,
        summary: String? = nil
    ) {
        self.imdbId = imdbId
        self.title = title
        self.genre = genre
        self.rating = rating
        self.summary = summary
    }
}

extension Movie: Equatable { }
