//
//  ImageElementImpl.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation
import UIKit

open class ImageElementImpl: ElementView, ImageElement {

    private let imageView = UIImageView()

    public var image: UIImage? {
        set {
            imageView.image = newValue
        }
        get {
            return imageView.image
        }
    }

    open override var contentMode: ContentMode {
        set {
            imageView.contentMode = newValue
        }
        get {
            return imageView.contentMode
        }
    }
    
    override open var tintColor: UIColor? {
        set {
            if let tintColor = newValue {
                imageView.image = image?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = tintColor
            } else {
                imageView.image = image?.withRenderingMode(.alwaysOriginal)
            }
        }
        get {
            return imageView.tintColor == .clear ? nil : imageView.tintColor
        }
    }

    public required init() {
        super.init()
        contentMode = .scaleAspectFit
        setupElements()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func contentMode(_ contentMode: ContentMode) -> ImageElement {
        imageView.contentMode = contentMode
        return self
    }

    public func image(_ image: UIImage?) -> ImageElement {
        imageView.image = image
        return self
    }

    private func setupElements() {

        func setupImageView() {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imageView)
            let constraints = [
                imageView.topAnchor.constraint(equalTo: topAnchor),
                imageView.rightAnchor.constraint(equalTo: rightAnchor),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
                imageView.leftAnchor.constraint(equalTo: leftAnchor)
            ]
            NSLayoutConstraint.activate(constraints)
        }

        setupImageView()
    }
}
