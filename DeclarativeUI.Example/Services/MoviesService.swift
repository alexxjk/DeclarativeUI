//
//  MoviesService.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/7/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation
import ReactiveKit

protocol MoviesService {
    func load() -> Signal<[Movie], ServiceError>
}

