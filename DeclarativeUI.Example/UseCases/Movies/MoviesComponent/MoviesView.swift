//
//  MoviesView.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/10/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit

final class MoviesView: ViewControllerContainerView {
    
    private var destinations: MoviesElement!
    
    required init() {
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func doOnAppearing() {
        appStore.subscribe(destinations) {
            return $0.select {
                $0.moviesState
            }
        }
    }
    
    override func doOnDisappearing() {
        appStore.unsubscribe(destinations)
    }
    
    private func setupElements() {
        
        destinations = addElement {
            ListElementMaker<Movie, MovieElement, MoviesElement>()
                .pin(at: .leading(respectingSafeArea: false, respectingLayuMargings: false))
                .pin(at: .trailing(respectingSafeArea: false, respectingLayuMargings: false))
                .pin(at: Pin(type: .bottom))
                .pin(at: .top())

        }
    }
}

extension MoviesView: ElementableView {
    
    func build() {
        setupElements()
    }
}

