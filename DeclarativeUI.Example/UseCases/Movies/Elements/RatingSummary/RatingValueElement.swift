//
//  RatingValueElement.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/11/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit
import ReSwift


final class RatingValueElement: ElementView {
    
    var props: Props? {
        didSet {
            guard let props = props else {
                return
            }
            
            value.text = Formatter.number(props.score * 100, maximumFractionDigits: 0)
        }
    }
    
    private var value: TextElement!
    
    public required init() {
        super.init()
        backgroundColor = Color.main.uiColor
        widthToSet = 68
        heightToSet = 68
        corners = CornerRadius(value: 34)
        setupElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupElements() {
    
        value = addElement {
            TextElementMaker()
                .textStyleFactory(TextStyleBuilder().font(.title(size: 22)).color(.title))
                .text("21")
                .pin()
        }
    }
    
    struct Props {
        
        let score: Float
        
        init(score: Float) {
            self.score = score
        }
    }
}

