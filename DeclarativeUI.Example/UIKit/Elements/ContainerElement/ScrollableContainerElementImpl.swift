//
//  ScrollableContainerElementImpl.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit

open class ScrollableContainerElementImpl: ElementView, ContainerElement {
    
    private let scrollView = UIScrollView()
    
    public required init() {
        
        super.init()
        setupElements()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupElements() {
        
        func setupScrollView() {
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.showsVerticalScrollIndicator = false
            scrollView.showsHorizontalScrollIndicator = false
            addSubview(scrollView)
            let constraints = [
                scrollView.topAnchor.constraint(equalTo: topAnchor),
                scrollView.rightAnchor.constraint(equalTo: rightAnchor),
                scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
                scrollView.leftAnchor.constraint(equalTo: leftAnchor)
            ]
            NSLayoutConstraint.activate(constraints)
        }
        
        func setupContentView() {
            contentView = ElementView()
            guard let contentView = contentView else { return }
            contentView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(contentView)
            let constraints = [
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor)
            ]
            NSLayoutConstraint.activate(constraints)
            
            let equalHeights = contentView.heightAnchor.constraint(equalTo: heightAnchor)
            equalHeights.isActive = true
        }
        
        setupScrollView()
        setupContentView()
    }
}
