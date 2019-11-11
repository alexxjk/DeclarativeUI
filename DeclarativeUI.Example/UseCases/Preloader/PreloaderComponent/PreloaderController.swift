//
//  PreloaderController.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/9/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit
import ReactiveKit

final class PreloaderController: ViewController<PreloaderView> {

    weak var delegate: PreloaderViewControllerDelegate?

    override var id: String { return "PreloaderViewController" }

    init(logger: SLLogger) {
        super.init(logger: logger, withAnimatableGradient: true)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.logger = logger
        rootView.onFinish = { [weak self] in
            guard let self = self else {
                return
            }
            self.delegate?.preloaderViewControllerDidFinish()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateBackground()
    }
    
    override func useCaseWillFinish(in timeInterval: TimeInterval) {
        self.rootView.finishLoadingAnimation(in: timeInterval)
        self.animateBackgroundToDefaultState(in: timeInterval)
        
    }

}

protocol PreloaderViewControllerDelegate: class {
    func preloaderViewControllerDidFinish()
}

