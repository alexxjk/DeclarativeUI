//
//  UseCase.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation
import UIKit

class UseCase {

    /**
    Use case unique identifier
    */
    var id: String

    /**
    Use case starting view controller
    */
    var startingViewController: ViewControllerBase
    
    var activeViewController: ViewControllerBase

    /**
    Indicates that use case requires a navigation controller
    */
    var needsNavigationController: Bool

    var logger: SLLogger
    
    var dispatcher: CommandsDispatcher
    
    init(
        id: String,
        startingViewController: ViewControllerBase,
        needsNavigationController: Bool,
        logger: SLLogger,
        dispatcher: CommandsDispatcher)
    {
        self.id = id
        self.startingViewController = startingViewController
        self.activeViewController = startingViewController
        self.needsNavigationController = needsNavigationController
        self.logger = logger
        self.dispatcher = dispatcher
    }
    
    /**
    Sets key-window root view controller
    */
    func start(withAnimation animateOnLoading: Bool = false) {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        let rootViewController: UIViewController = {
            return needsNavigationController
                    ? NavigationController(rootViewController: self.startingViewController)
                    : startingViewController
        }()
        if animateOnLoading {
            let snapshot = (window.snapshotView(afterScreenUpdates: true))!
            rootViewController.view.addSubview(snapshot)
            window.rootViewController = rootViewController
            UIView.transition(with: snapshot, duration: 0.3, options: [.transitionCrossDissolve], animations: {
                snapshot.alpha = 0
            }) { _ in
                snapshot.removeFromSuperview()
            }
        } else {
            window.rootViewController = rootViewController
        }
        
        logger.log(entry: SLEntry(onDate: Date(), type: .message, message: "Use case \(id.uppercased()) started."))
        doOnStarted()
    }
    
    func finish() {
        logger.log(entry: SLEntry(onDate: Date(), type: .message, message: "Use case \(id.uppercased()) is finishing."))
        doOnFinish()
    }
    
    func doOnStarted() {
        
    }
    
    func doOnFinish() {
        
    }
    
}

