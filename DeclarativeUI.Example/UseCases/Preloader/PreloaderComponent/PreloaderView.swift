//
//  PreloaderView.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/9/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit
import ReSwift

final class PreloaderView: ViewControllerContainerView {

    weak var logger: SLLogger?

    private var logo: ImageElement!
    
    private var moto: TextElement!
    
    private let loadingAnimationId = "id.loadingAnimation"
    
    private let motoAppearanceAnimationId = "id.motoAppearanceAnimation"

    var onFinish: (() -> Void)?
    
    override func doOnAppearing() {
        appStore.subscribe(self)
    }
    
    override func doOnDisappearing() {
        appStore.unsubscribe(self)
    }
    
    private func setupElements() {

        logo = addElement {
            ActivityIndicatorMaker().pin()
        }
        
        moto = addElement {
            TextElementMaker()
                .textStyleFactory(TextStyleBuilder().font(.title(size: 16)).color(.uiTint))
                .text("Discover movies")
                .opacity(0)
                .behavior(Behavior.Animation(
                    trigger: .onAppeared,
                    properties: [AnimationProperty.opacity(to: 1), AnimationProperty.scale(to: .one)],
                    duration: 0.37,
                    delay: 0.3,
                    curve: .easeIn)
                )
                .scale(ScaleFactor(x: 0.4, y: 1))
                .pin(at: Pin(type: .bottom, offset: 65))
                .pin(at: Pin(type: .centerHorizontaly))
        }
        
        let logoLoadingAnimation = Behavior.Animation(
            id: loadingAnimationId,
            properties: [
                AnimationProperty.scale(to: ScaleFactor(factor: 0.9)), AnimationProperty.opacity(to: 0.9)
            ],
            isPerpetual: true,
            isReversed: true,
            duration: 2.5,
            curve: .linear
        )
        logo.attach(logoLoadingAnimation)
    }

    func startLoadingAnimation() {
        logo.triggerBehavior(withId: loadingAnimationId)
    }
    
    func finishLoadingAnimation(in interval: TimeInterval) {
        logo.detach(behaviorWithId: loadingAnimationId)
        
        let logoScale = Behavior.create(from:
            .animation(
                properties: [AnimationProperty.opacity(to: 0.1), AnimationProperty.scale(to: .zero)],
                duration: interval
            )
        )
        logo.attach(logoScale)
        
        let motoOpacity = Behavior.create(from: .opacity(toValue: 0, duration: interval))
        moto.attach(motoOpacity)
    }
}


extension PreloaderView: ElementableView {
    
    func build() {
        
        setupElements()
        
    }
}

extension PreloaderView: StoreSubscriber {
    func newState(state: AppState) {
        let moviesState = state.moviesState
        switch moviesState.movies {
        case .loading:
            startLoadingAnimation()
        default:
            break
        }
    }
}

