//
//  AppState.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation
import ReSwift

struct AppState {
    var moviesState: MoviesState
}

func appStateReducer(action: ReSwift.Action, state: AppState?) -> AppState {
    
    return AppState(
        moviesState: MoviesState.reducer(action: action, state: state?.moviesState)
    )
}

extension AppState {
    enum Action: ReSwift.Action {
        
    }
}

extension AppState: StateType { }

extension AppState: Equatable { }
