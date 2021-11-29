//
//  PersistentListProvider.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-16.
//

import Foundation

final class PersistentListProvider: DocumentListProvider, ReceiptListProvider {
    
    let configuration: Configuration
    
    init(configuration: Configuration) {
        self.configuration = configuration
    }
    
    // MARK: - DocumentListProvider conformance
    var documentListProviderState: DocumentListProviderState = .idle(result: nil) {
        didSet {
            guard self.documentListProviderState != oldValue else { return }
            
            self.documentListProviderDelegate?.documentListProviderDidUpdateState(self)
        }
    }
    
    weak var documentListProviderDelegate: DocumentListProviderDelegate? = nil
    
    func fetchDocuments() {
        self.documentListProviderState = DocumentListProviderState.busy
        guard let url = self.configuration.bundle.url(forResource: self.configuration.documentsFileName, withExtension: "json") else {
            return self.documentListProviderState = .idle(result: .failure(ListProviderError.configuration))
        }
        guard let data = try? Data(contentsOf: url) else {
            return self.documentListProviderState = .idle(result: .failure(ListProviderError.reachability))
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
    
    // MARK: - ReceiptListProvider conformance
    var receiptListProviderState: ReceiptListProviderState = .idle(result: nil) {
        didSet {
            guard self.receiptListProviderState != oldValue else { return }
            
            self.receiptListProviderDelegate?.receiptListProviderDidUpdateState(self)
        }
    }
    
    weak var receiptListProviderDelegate: ReceiptListProviderDelegate?
    
    func fetchReceiptsWithOffset(_ offset: Int, andLimit limit: Int) {
        guard let url = self.configuration.bundle.url(forResource: self.configuration.receiptsFileName, withExtension: "json") else {
            return self.receiptListProviderState = ReceiptListProviderState.idle(result: .failure( .configuration))
        }
        guard let data = try? Data(contentsOf: url) else {
            return self.receiptListProviderState = ReceiptListProviderState.idle(result: .failure( .reachability))
        }
        do {
            let receiptList = try Self.Helper.jsonDecoder.decode(ReceiptList.self, from: data)
            self.receiptListProviderState = ReceiptListProviderState.idle(result: .success(receiptList.receipts))
        } catch {
            self.receiptListProviderState = ReceiptListProviderState.idle(result: .failure( .decode))
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

// MARK: - Private helpers
private extension PersistentListProvider {
    
    enum Helper {
        
        static let jsonDecoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.convertFromSnakeCase
            decoder.dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.iso8601
            return decoder
        }()
    }
}
