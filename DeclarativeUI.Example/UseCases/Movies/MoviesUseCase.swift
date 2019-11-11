//
//  MoviesUseCase.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/10/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit

class MoviesUseCase: UseCase {

    init(logger: SLLogger, dispatcher: CommandsDispatcher) {
        let startingViewController = MoviesContainerController(logger: logger, dispatcher: dispatcher)
        super.init(
            id: "movies",
            startingViewController: startingViewController,
            needsNavigationController: false,
            logger: logger,
            dispatcher: dispatcher
        )
    }
}

