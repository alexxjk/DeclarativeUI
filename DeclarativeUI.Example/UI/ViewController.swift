//
//  ViewController.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/9/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit

class ViewController<TView: ViewControllerContainerView & ElementableView>: ElementableViewController<TView> {
    
    private let withAnimatableGradient: Bool

    private let gradientBackgroundLayer = CAGradientLayer()

    private let topColorsForAnimatableGradient = [UIColor(hex: 0xF5D547).cgColor, UIColor(hex: 0xDB3069).cgColor]
    
    private let bottomGradientColor = UIColor(hex: 0xDB3069).cgColor

    var applyGradientBackground: Bool { return true }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    init(logger: SLLogger, withAnimatableGradient: Bool) {
        self.withAnimatableGradient = withAnimatableGradient
        super.init(logger: logger)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewRespectsSystemMinimumLayoutMargins = false
        extendedLayoutIncludesOpaqueBars = true
        applyStyle()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientBackgroundLayer.frame = view.frame
    }
    
    override func loadView() {
        super.loadView()
        view.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
    }
    
    func animateBackground() {
        
        let animations = CAAnimationGroup()
        animations.duration = 2.7
        animations.fillMode = .forwards
        animations.isRemovedOnCompletion = false
        animations.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animations.repeatCount = 9999
        animations.autoreverses = true
        
        let colorsAnimation = CABasicAnimation(keyPath: "colors")
        colorsAnimation.fillMode = .forwards
        colorsAnimation.isRemovedOnCompletion = false
        colorsAnimation.fromValue = [topColorsForAnimatableGradient[0], bottomGradientColor]
        colorsAnimation.toValue = [topColorsForAnimatableGradient[1], Color.background.cgColor]
        
        animations.animations = [colorsAnimation]
        gradientBackgroundLayer.add(animations, forKey: "bacgkroundColors")
    }
    
    func animateBackgroundToDefaultState(in interval: TimeInterval = 1.0) {
        let colors = gradientBackgroundLayer.presentation()?.colors
        gradientBackgroundLayer.removeAnimation(forKey: "bacgkroundColors")
        
        let animations = CAAnimationGroup()
        animations.duration = interval
        animations.fillMode = .forwards
        animations.isRemovedOnCompletion = false
        
        let colorsAnimation = CABasicAnimation(keyPath: "colors")
        colorsAnimation.fromValue = colors
        colorsAnimation.toValue = [Color.background.cgColor, Color.background.cgColor]
        
        let endPointAnimation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.endPoint))
        endPointAnimation.toValue = CGPoint(x: 0, y: 1)
    
        animations.animations = [colorsAnimation, endPointAnimation]
        gradientBackgroundLayer.add(animations, forKey: "bacgkroundColors1")
    }

    private func applyStyle() {

        func applyBackground() {
            
            if withAnimatableGradient {
                gradientBackgroundLayer.removeFromSuperlayer()
                gradientBackgroundLayer.locations = [0.0, 1.0]
                gradientBackgroundLayer.startPoint = CGPoint(x: 0, y: 0)
                gradientBackgroundLayer.endPoint = CGPoint(x: 1, y: 1)
                view.layer.insertSublayer(gradientBackgroundLayer, at: 0)
                gradientBackgroundLayer.colors = withAnimatableGradient ?
                    [topColorsForAnimatableGradient[0], bottomGradientColor] :
                    [UIColor(hex: 0xF99F00).cgColor, bottomGradientColor]
            } else {
                view.backgroundColor = Color.background.uiColor
            }
            
        }

        func setupNavigationBar() {
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.barTintColor = Color.background.uiColor
            navigationController?.navigationBar.tintColor = Color.uiTint.uiColor
            navigationController?.navigationBar.titleTextAttributes = TextStyleBuilder().font(.title(size: 20)).color(.title)
                .makeAttributes()
        }
        
        if applyGradientBackground { applyBackground() }
        setupNavigationBar()
    }
}
