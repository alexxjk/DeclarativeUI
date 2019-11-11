//
//  ListElementImpl.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation
import UIKit

open class ListElementImpl<TItem, TItemElement: ListItemElementImpl<TItem>>: ElementView, ListElement, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private var items: [TItem]?
    
    private var collectionView: UICollectionView!
    private let itemCellId = "itemCellId"
    
    public required init() {
        items = [TItem]()
        super.init()
        preservesSuperviewLayoutMargins = true
        setupElements()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(with items: [TItem], animated: Bool) {
        let oldItems = self.items
        self.items = items
        self.collectionView.performBatchUpdates({
            let itemsToDelete = (oldItems ?? []).enumerated().map { IndexPath(item: $0.offset, section: 0) }
            let itemsToInsert = items.enumerated().map { IndexPath(item: $0.offset, section: 0) }
            collectionView.deleteItems(at: itemsToDelete)
            collectionView.insertItems(at: itemsToInsert)
        })
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    public func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellId, for: indexPath)
            as! CollectionViewCell
        if let item = items?[indexPath.item] {
            let element = TItemElement.init(model: item)
            cell.set(element: element)
        }
        return cell
    }
    
    private func setupElements() {
        
        func setupCollectionView() {
            let flowLayout = FlowLayout()
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 16
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.sectionInset = .zero
            collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 104, right: 16)
            collectionView.indicatorStyle = .black
            collectionView.contentInsetAdjustmentBehavior = .never
            collectionView.backgroundColor = .clear
            collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: itemCellId)
            addSubview(collectionView)
            let constraints = [
                collectionView.topAnchor.constraint(equalTo: topAnchor),
                collectionView.rightAnchor.constraint(equalTo: rightAnchor),
                collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
                collectionView.leftAnchor.constraint(equalTo: leftAnchor)
            ]
            NSLayoutConstraint.activate(constraints)
            collectionView.delegate = self
            collectionView.dataSource = self
        }
        
        setupCollectionView()
    }
    
    private class CollectionViewCell: UICollectionViewCell {
        
        private var elementView: TItemElement?
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            directionalLayoutMargins = NSDirectionalEdgeInsets(
                top: layoutMargins.top,
                leading: layoutMargins.left,
                bottom: layoutMargins.bottom,
                trailing: layoutMargins.right
            )
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        

        func set(element: TItemElement) {
            elementView?.removeFromSuperview()
            elementView = element
            addSubview(element)
            let heightConstraint = heightAnchor.constraint(equalTo: element.heightAnchor)
            heightConstraint.priority = .defaultHigh
            let constraints = [
                heightConstraint,
                element.centerYAnchor.constraint(equalTo: centerYAnchor),
                element.leftAnchor.constraint(equalTo: leftAnchor),
                element.rightAnchor.constraint(equalTo: rightAnchor)
            ]
            NSLayoutConstraint.activate(constraints)
            layoutIfNeeded()
        }
        
    }
    
    private class FlowLayout: UICollectionViewFlowLayout {

        override init() {
            super.init()
            estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
            guard let layoutAttributes = super.layoutAttributesForItem(at: indexPath) else { return nil }
            guard let collectionView = collectionView else { return nil }
            layoutAttributes.bounds.size.width = collectionView.frame.width - sectionInset.left - sectionInset.right - collectionView.contentInset.left - collectionView.contentInset.right - 0.5
            return layoutAttributes
        }

        override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            guard let superLayoutAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
            guard scrollDirection == .vertical else { return superLayoutAttributes }

            let computedAttributes = superLayoutAttributes.compactMap { layoutAttribute in
                return layoutAttributesForItem(at: layoutAttribute.indexPath)
            }
            return computedAttributes
        }

        override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
            return true
        }

    }
}

open class ListItemElementImpl<TItem>: ElementView {
    
    public let model: TItem
    
    public required init(model: TItem) {
        self.model = model
        super.init()
    }
    
    required public init() {
        fatalError()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func update(with model: TItem) {
        
    }
}

