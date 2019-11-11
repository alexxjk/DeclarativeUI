//
//  MoviesContainerView.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/10/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit

final class MoviesContainerView: ViewControllerContainerView {
    
    private var dispatcher: CommandsDispatcher!
    
    var moviesContainer: ContainerElement!
    
    private var score: RatingScoreElement!
    
    private var ratingScore: RatingSummaryElement!
    
    required init() {
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(dispatcher: CommandsDispatcher) {
        self.dispatcher = dispatcher
    }
    
    private func setupElements() {
        
        moviesContainer = addElement {
            ContainerElementMaker()
                .background(.black)
                .pin(at: .leading(respectingSafeArea: false, respectingLayuMargings: false))
                .pin(at: .trailing(respectingSafeArea: false, respectingLayuMargings: false))
                .pin(at: Pin(type: .bottom))
                .pin(at: .top(respectingSafeArea: false, respectingLayuMargings: false))

        }
        
        ratingScore = addElement {
            RatingSummmaryMaker()
                .pin(at: .top(respectingSafeArea: false, respectingLayuMargings: false))
                .pin(at: .trailing(respectingSafeArea: false, respectingLayuMargings: false))
                .pin(at: .bottom(respectingSafeArea: false, respectingLayuMargings: false))
                .pin(at: .leading(respectingSafeArea: false, respectingLayuMargings: false))
        }
        
        score = addElement {
             RatingScoreMaker()
                 .pin(at: Pin(type: .bottom, respectingSafeArea: false, respectingLayuMargings: false))
                 .pin(at: .leading(respectingSafeArea: false, respectingLayuMargings: false))
                 .pin(at: .trailing(respectingSafeArea: false, respectingLayuMargings: false))
                 .behavior(Behavior.AppearanceAnimation(type: .slideFromBottom))
                 .on(interactionStarted: ratingScoreTrackerDidStartInteraction)
                 .on(interactionEnded: ratingScoreTrackerDidStartInteraction)
                 .on(valueChanging: ratingScoreTrackerChangingValue)
         }
    
    }
    
    func ratingScoreTrackerChangingValue(_ value: Float) {
        dispatcher.dispatch(command: MoviesCommand.set(ratingScopre: value))
    }
    
    func ratingScoreTrackerDidStartInteraction() {
        ratingScore.toggle()
    }
}

extension MoviesContainerView: ElementableView {
    
    func build() {
        setupElements()
        appStore.subscribe(ratingScore) {
            return $0.select {
                $0.moviesState
            }
        }
    }
}



