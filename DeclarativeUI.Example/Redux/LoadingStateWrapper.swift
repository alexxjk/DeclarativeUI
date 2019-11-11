//
//  LoadingStateWrapper.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/6/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import Foundation

enum LoadingStateWrapper<TModel: Any & Equatable, TError: Error & Equatable>: Equatable {
    
    case undefined
    case loading
    case error(TError)
    case loaded(TModel)
    
    static func == (lhs: LoadingStateWrapper<TModel, TError>, rhs: LoadingStateWrapper<TModel, TError>) -> Bool {
        switch lhs {
        case .undefined:
            switch rhs {
            case .undefined:
                return true
            default:
                return false
            }
        case .loading:
            switch rhs {
            case .loading:
                return true
            default:
                return false
            }
        case .error(let lhsError):
            switch rhs {
            case .error(let rhsError):
                return lhsError == rhsError
            default:
                return false
            }
        case .loaded(let lhsModel):
            switch rhs {
            case .loaded(let rhsModel):
                return lhsModel == rhsModel
            default:
                return false
            }
        }
    }
}
