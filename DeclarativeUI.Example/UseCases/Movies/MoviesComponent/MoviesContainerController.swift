//
//  MoviesContainerController.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/10/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit

class MoviesContainerController: ViewController<MoviesContainerView> {

    private let dispatcher: CommandsDispatcher
    
    init(logger: SLLogger, dispatcher: CommandsDispatcher) {
        self.dispatcher = dispatcher
        super.init(logger: logger, withAnimatableGradient: false)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.set(dispatcher: dispatcher)
        let nc = NavigationController(rootViewController: MoviesController(logger: logger, dispatcher: dispatcher))
        if let ncView = nc.view, let storiesContainer = rootView.moviesContainer as? UIView {
            ncView.translatesAutoresizingMaskIntoConstraints = false
            let constraints = [
                ncView.topAnchor.constraint(equalTo: storiesContainer.topAnchor),
                ncView.trailingAnchor.constraint(equalTo: storiesContainer.trailingAnchor),
                ncView.bottomAnchor.constraint(equalTo: storiesContainer.bottomAnchor),
                ncView.leadingAnchor.constraint(equalTo: storiesContainer.leadingAnchor)
            ]
            (rootView.moviesContainer as! UIView).addSubview(nc.view)
            NSLayoutConstraint.activate(constraints)
            addChild(nc)
            nc.didMove(toParent: self)
        }
    }

    @objc private func handleMenuTap() {

    }
    
    @objc private func handleWaypointsTap() {
        
    }
}
