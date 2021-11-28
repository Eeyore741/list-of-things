//
//  ListProviderState.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-27.
//

import Foundation

enum ListProviderState<R> {
    case idle(result: Result<[R], ListProviderError>?)
    case busy
}

extension ListProviderState: Equatable where R: Equatable {
    
    static func == (lhs: ListProviderState<R>, rhs: ListProviderState<R>) -> Bool {
        switch (lhs, rhs) {
        case (.busy, .busy), (.idle(.none), .idle(.none)):
            return true
        case (.idle(let .some(lhsResult)), .idle(let .some(rhsResult))):
            switch (lhsResult, rhsResult) {
            case (.failure(let lhsError), .failure(let rhsError)):
                return lhsError == rhsError
            case (.success(let lhsList), .success(let rhsList)):
                return lhsList == rhsList
            default:
                return false
            }
        default:
            return false
        }
    }
}
