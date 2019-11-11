//
//  MoviesController.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/10/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit

class MoviesController: ViewController<MoviesView> {

    private let dispatcher: CommandsDispatcher
    
    init(logger: SLLogger, dispatcher: CommandsDispatcher) {
        self.dispatcher = dispatcher
        super.init(logger: logger, withAnimatableGradient: false)
        title = "Movies"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem =
            UIBarButtonItem(
                image: Icon.menu.image,
                style: .plain,
                target: self,
                action: #selector(handleMenuTap)
            )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @objc private func handleMenuTap() {

    }
    
    @objc private func handleWaypointsTap() {
        
    }
}
