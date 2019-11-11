//
//  MoviesState.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation
import ReSwift

struct MoviesState {
    
    var movies: LoadingStateWrapper<[Movie], ServiceError>
    
    var ratingScore: Float

}

extension MoviesState {
    enum Action: ReSwift.Action {
        
        case setLoadingStateForMovies(_: LoadingStateWrapper<[Movie], ServiceError>)
        
        case setRatingScore(_: Float)
    }
}

extension MoviesState {

    static func reducer(action: ReSwift.Action, state: MoviesState?) -> MoviesState {
        var state = state ?? MoviesState(movies: .undefined, ratingScore: 0.5)
        
        guard let action = action as? Action else { return state }
        
        switch action {
        case .setLoadingStateForMovies(let loadingState):
            state.movies = loadingState
        case .setRatingScore(let score):
            state.ratingScore = score
        }
        return state
    }
}

extension MoviesState: StateType { }

extension MoviesState: Equatable { }

