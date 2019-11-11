//
//  CommandsDispatcherProvider.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/7/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation
import ReactiveKit

class CommandsDispatcherProvider: CommandsDispatcher {
    
    private let bag = DisposeBag()
    
    private let moviesService: MoviesService
    
    init(moviesService: MoviesService) {
        self.moviesService = moviesService
    }
    
    func dispatch(command: Command) {
        switch command  {
        case let moviesCommand as MoviesCommand:
            handle(moviesCommand)
        case let appCommand as AppCommand:
            handle(appCommand)
        default:
            break
        }
    }
    
    
}

private extension CommandsDispatcherProvider {
    func handle(_ moviesCommand: MoviesCommand) {
        switch moviesCommand {
        case .load:
            loadMovies()
        case .set(let ratingScore):
            appStore.dispatch(MoviesState.Action.setRatingScore(ratingScore))
        }
    }
    
    func loadMovies() {
        appStore.dispatch(MoviesState.Action.setLoadingStateForMovies(.loading))
        moviesService.load()
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .handleEvents(
                receiveOutput: { [unowned self] movies in appStore.dispatch(MoviesState.Action.setLoadingStateForMovies(.loaded(movies)))
                },
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        appStore.dispatch(
                            MoviesState.Action.setLoadingStateForMovies(.error(error))
                        )
                    default: break
                    }
                })
            .observe(with: { _ in })
            .dispose(in: bag)
    }
}


private extension CommandsDispatcherProvider {
    func handle(_ appCommand: AppCommand) {
        
    }
}

