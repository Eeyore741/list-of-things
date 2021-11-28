//
//  ListProvider.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-16.
//

import Foundation

typealias DocumentListProviderState = ListProviderState<Document>

protocol DocumentListProviderDelegate: AnyObject {
    func documentListProviderDidUpdateState(_ provider: DocumentListProvider)
}

protocol DocumentListProvider {
    var documentListProviderState: DocumentListProviderState { get }
    var documentListProviderDelegate: DocumentListProviderDelegate? { set get }
    func fetchDocuments()
}

extension DocumentListProvider {
    func documentAtIndex(_ index: Int) -> Document? {
        guard case let .idle(.some(result)) = documentListProviderState else { return nil }
        
        switch result {
        case .failure(_):
            return nil
        case .success(let documents):
            guard documents.indices.contains(index) else { return nil }
            
            return documents[index]
        }
    }
}
