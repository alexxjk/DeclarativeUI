//
//  RatingsScoreMaker.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/11/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit

final class RatingScoreMaker<TScoreElement: RatingScoreElementImpl>: ElementMaker<TScoreElement> {
    
    private var valueChanged: ((_ value: Float) -> Void)?
    
    private var valueChanging: ((_ value: Float) -> Void)?
    
    private var interfactionStarted: (() -> Void)?
    
    private var interactionEnded: (() -> Void)?
    
    override init() {
        super.init()
        _ = background(Color.background.alpha(0.9))
    }
    
    override func make() -> TScoreElement {
        let element = super.make()
        element.heightToSet = 110
        element.doOnValueChanged = valueChanged
        element.doOnValueChanging = valueChanging
        element.doOnInteractionStarted = interfactionStarted
        element.doOnInteractionEnded = interactionEnded
        return element
    }
    
    func on(valueChanged: @escaping ((_ value: Float) -> Void)) -> Self {
        self.valueChanged = valueChanged
        return self
    }
    
    func on(valueChanging: @escaping ((_ value: Float) -> Void)) -> Self {
        self.valueChanging = valueChanging
        return self
    }
    
    func on(interactionStarted: @escaping (() -> Void)) -> Self {
        self.interfactionStarted = interactionStarted
        return self
    }
    
    func on(interactionEnded: @escaping (() -> Void)) -> Self {
        self.interactionEnded = interactionEnded
        return self
    }
}

