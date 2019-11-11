//
//  ElementableViewController.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/7/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit

class ElementableViewController<TView: ViewControllerContainerView & ElementableView>: ViewControllerBase {

    let logger: SLLogger

    var rootView: TView {
        return (view as! TView)
    }

    var id: String {
        return String(describing: self)
    }

    init(logger: SLLogger) {
        self.logger = logger
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        logger.log(entry: SLEntry(onDate: Date(), type: .message, message: "VC \(id) did load."))
        super.viewDidLoad()
        rootView.build()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        logger.log(entry: SLEntry(onDate: Date(), type: .message, message: "VC \(id) will appear."))
        super.viewWillAppear(animated)
        rootView.doOnAppearing()
    }

    override func viewDidAppear(_ animated: Bool) {
        logger.log(entry: SLEntry(onDate: Date(), type: .message, message: "VC \(id) did appear."))
        super.viewDidAppear(animated)
        rootView.onAppeared()
    }

    override func loadView() {
        view = TView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

