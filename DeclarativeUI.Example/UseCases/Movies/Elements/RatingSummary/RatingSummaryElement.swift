//
//  RatingSummaryElement.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/11/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit
import ReSwift


final class RatingSummaryElement: ContainerElementImpl {
    
    private var isAtive = false
    
    private var title: TextElement!
    
    private var score: RatingValueElement!
    
    private var ratingsHint: TextElement!
    private var ratingsHintOpacity: Float {
        guard let props = props else {
            return 1
        }
        return 0.5 + 0.5 * (1 - props.score)
    }
    
    private var relevanceHint: TextElement!
    private var relevanceHintOpacity: Float {
        guard let props = props else {
            return 1
        }
        return 0.5 + 0.5 * props.score
    }
    
    var props: Props? {
        didSet {
            updateHints()
            score.props = RatingValueElement.Props(score: props?.score ?? 0)
        }
    }
    
    public required init() {
        super.init()
        isUserInteractionEnabled = false
        preservesSuperviewLayoutMargins = true
        setupElements()
        renderState(animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toggle() {
        isAtive = !isAtive
        isUserInteractionEnabled = isAtive
        renderState()
    }
    
    private func renderState(animated: Bool = true) {
        if animated {
            let animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeOut) {
                self.backgroundColor = self.isAtive ? Color.overlay.uiColor : .clear
                self.title.opacity = self.isAtive ? 1 : 0
                self.score.opacity = self.isAtive ? 1 : 0
                self.ratingsHint.opacity = self.isAtive ? self.ratingsHintOpacity : 0
                self.relevanceHint.opacity = self.isAtive ? self.relevanceHintOpacity : 0
            }
            animator.startAnimation(afterDelay: 0)
        } else {
            backgroundColor = isAtive ? Color.overlay.uiColor : .clear
            title.opacity = isAtive ? 1 : 0
            score.opacity = isAtive ? 1 : 0
            ratingsHint.opacity = isAtive ? ratingsHintOpacity : 0
            relevanceHint.opacity = isAtive ? relevanceHintOpacity : 0
        }
    }
    
    private func setupElements() {
        
        let hintTextStyleBuilder = TextStyleBuilder()
            .font(.accent(size: 16))
            .color(.secondaryText)
        
        title = addElement {
            TextElementMaker()
                .textStyleFactory(TextStyleBuilder().font(.title(size: 20)).color(.title))
                .text("Relevance Score")
                .pin(at: Pin(type: .centerHorizontaly))
                .pin(at: .top(offset: 10))
        }
        
        score = addElement {
            RatingValueElementMaker()
                .pin(at: Pin(type: .centerHorizontaly))
                .pin(at: Pin(type: .centerVerticaly))
        }
        
        ratingsHint = addElement {
            TextElementMaker()
                .textStyleFactory(hintTextStyleBuilder)
                .text("More popular")
                .pin(at: .trailingLeading(toElement: score, offset: -16))
                .pin(at: .centerVerticaly())
        }
        
        relevanceHint = addElement {
            TextElementMaker()
                .textStyleFactory(hintTextStyleBuilder)
                .text("More relevant")
                .pin(at: .leadingTrailing(toElement: score, offset: 16))
                .pin(at: .centerVerticaly())
        }
    }
    
    private func updateHints() {
        ratingsHint.opacity = isAtive ? ratingsHintOpacity : 0
        relevanceHint.opacity = isAtive ? relevanceHintOpacity : 0
    }
    
    struct Props {
        
        let score: Float
        
        init(score: Float) {
            self.score = score
        }
    }
}

extension RatingSummaryElement: StoreSubscriber {
    func newState(state: MoviesState) {
        props = Props(score: state.ratingScore)
    }
}
