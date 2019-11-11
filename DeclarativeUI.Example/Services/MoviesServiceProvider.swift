//
//  MoviesProvider.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/7/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation
import ReactiveKit

class MoviesServiceProvider: MoviesService {
    func load() -> Signal<[Movie], ServiceError> {
        return Signal<[Movie], ServiceError>.init(just: self.movies(), after: 1)
    }
    
    private func movies() -> [Movie] {
        let all = [
            Movie(imdbId: "1", title: "From Dusk Till Dawn", genre: "Action", rating: 7.3, summary: "Two criminals and their hostages unknowingly seek temporary refuge in a truck stop populated by vampires, with chaotic results."),
            Movie(imdbId: "2", title: "Star Wars: The Rise of Skywalker", genre: "Sci-fi", rating: 8.1, summary: "The surviving Resistance faces the First Order once more in the final chapter of the Skywalker saga."),
            Movie(imdbId: "3", title: "The Big Bang Theory", genre: "Comedy", rating: 8.2, summary: "A woman who moves into an apartment across the hall from two brilliant but socially awkward physicists shows them how little they know about life outside of the laboratory."),
            Movie(imdbId: "4", title: "Batman Begins", genre: "Action", rating: 6.4, summary: "After training with his mentor, Batman begins his fight to free crime-ridden Gotham City from corruption."),
            Movie(imdbId: "5", title: "The Godfather ", genre: "Drama", rating: 9.5, summary: "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.")
        ]
        return all
    }
}
