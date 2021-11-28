//
//  PersistentListProvider.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-16.
//

import Foundation

final class PersistentListProvider: DocumentListProvider {
    
    let configuration: Configuration
    
    init(configuration: Configuration) {
        self.configuration = configuration
    }
    
    // MARK: - DocumentListProvider conformance
    weak var documentListProviderDelegate: DocumentListProviderDelegate? = nil
    
    func fetchDocuments() {
        self.documentListProviderState = DocumentListProviderState.busy
        guard let url = self.configuration.bundle.url(forResource: self.configuration.documentsFileName, withExtension: "json") else {
            self.documentListProviderState = .idle(result: .failure(ListProviderError.configuration))
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            self.documentListProviderState = .idle(result: .failure(ListProviderError.reachability))
            return
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + self.configuration.delay) {
            do {
                let documents = try JSONDecoder().decode([Document].self, from: data)
                self.documentListProviderState = .idle(result: .success(documents))
            } catch {
                self.documentListProviderState = .idle(result: .failure(ListProviderError.decode))
            }
        }
    }
    
    var documentListProviderState: DocumentListProviderState = .idle(result: nil) {
        didSet {
            guard self.documentListProviderState != oldValue else { return }
            
            self.documentListProviderDelegate?.documentListProviderDidUpdateState(self)
        }
    }
}

extension PersistentListProvider {
    
    struct Configuration {
        let documentsFileName: String
        let receiptsFileName: String
        let bundle: Bundle
        let delay: TimeInterval
        
        init(documentsFileName: String, receiptsFileName: String, delay: TimeInterval = 0) {
            self.documentsFileName = documentsFileName
            self.receiptsFileName = receiptsFileName
            self.delay = delay
            class __ { }
            self.bundle = Bundle(for: __.self)
        }
    }
}
