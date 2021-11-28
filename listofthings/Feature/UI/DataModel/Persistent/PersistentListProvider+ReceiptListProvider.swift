//
//  PersistentListProvider- ReceiptListProvider.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-27.
//

import Foundation

extension PersistentListProvider: ReceiptListProvider {
    var receiptListProviderState: ReceiptListProviderState {
        .idle(result: nil)
    }
    
    func fetchReceiptsWithOffset(_ offset: Int, andLimit limit: Int) {
        fatalError()
    }
    
    func fetchReceiptsWithOffset(_ offset: Int, andLimit limit: Int) async throws -> ReceiptList {
        guard let url = self.configuration.bundle.url(forResource: self.configuration.receiptsFileName, withExtension: "json") else {
            throw ListProviderError.configuration
        }
        guard let data = try? Data(contentsOf: url) else {
            throw ListProviderError.reachability
        }
        do {
            return try Self.Helper.jsonDecoder.decode(ReceiptList.self, from: data)
        } catch {
            throw ListProviderError.decode
        }
    }
}

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
