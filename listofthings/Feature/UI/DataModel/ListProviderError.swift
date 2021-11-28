//
//  ListProviderError.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-16.
//

import Foundation

enum ListProviderError {
    case configuration
    case reachability
    case decode
}

extension ListProviderError: Error { }
