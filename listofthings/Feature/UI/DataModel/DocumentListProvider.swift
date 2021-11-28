//
//  ListProvider.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-16.
//

import Foundation

typealias DocumentListProviderState = ListProviderState

protocol DocumentListProvider {
    var documentListProviderState: DocumentListProviderState { get }
    func fetchDocuments() async throws -> [Document]
}
