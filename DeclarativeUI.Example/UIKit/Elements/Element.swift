//
//  Element.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit

public protocol Element {
    
    var opacity: Float { get set }
    
    var background: UIColor { get set }
    
    var scaleFactor: ScaleFactor { get set }
    
    var pins: Set<Pin> { get set }
    
    var height: Float { get }
    
    var width: Float { get }
    
    func attach(_ behavior: Behavior)
    
    func detach(behaviorWithId id: String)
    
    func triggerBehavior(withId id: String)
    
    func onAppeared()
    
    func pin(for type: Pin.`Type`) -> Pin?
    
    @discardableResult
    func update(pin: Pin, animated: Bool) -> Pin
    
    func toggleOpacity()
    
    init()
}
