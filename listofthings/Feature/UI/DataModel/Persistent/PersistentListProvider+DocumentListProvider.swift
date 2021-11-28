//
//  PersistentListProvider+DocumentListProvider.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-16.
//

import Foundation

extension PersistentListProvider: DocumentListProvider {
    
    var documentListProviderState: DocumentListProviderState {
        .idle
    }
    
    func fetchDocuments() async throws -> [Document] {
        guard let url = self.configuration.bundle.url(forResource: self.configuration.documentsFileName, withExtension: "json") else {
            throw ListProviderError.configuration
        }
        guard let data = try? Data(contentsOf: url) else {
            throw ListProviderError.reachability
        }
        do {
            return try JSONDecoder().decode([Document].self, from: data)
        } catch {
            throw ListProviderError.decode
        }
    }
}
