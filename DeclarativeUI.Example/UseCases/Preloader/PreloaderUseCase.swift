//
//  PreloaderUseCase.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/7/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation
import UIKit
import ReSwift

final class PreloaderUseCase: UseCase {

    init(logger: SLLogger, dispatcher: CommandsDispatcher) {
        let startingVC = PreloaderController(logger: logger)
        super.init(
            id: "preloader",
            startingViewController: startingVC,
            needsNavigationController: false,
            logger: logger,
            dispatcher: dispatcher
        )
        appStore.subscribe(self)
    }
    
    deinit {
        appStore.unsubscribe(self)
    }
    
    override func doOnFinish() {
        appStore.unsubscribe(self)
        moveToMovies()
    }
    
    override func doOnStarted() {
        dispatcher.dispatch(command: MoviesCommand.load)
    }

    private func moveToMovies() {
        let moviesUseCase = MoviesUseCase(logger: logger, dispatcher: dispatcher)
        moviesUseCase.start(withAnimation: true)
    }

}

extension PreloaderUseCase: StoreSubscriber {
    func newState(state: AppState) {
        let moviesState = state.moviesState
        switch moviesState.movies {
        case .loaded(_):
            activeViewController.useCaseWillFinish(in: 0.5)
            delay(0.5) {
                self.finish()
            }
        default:
            break
        }
    }
}
