//
//  PersistentListProvider.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-16.
//

import Foundation

final class PersistentListProvider {
    
    let configuration: Configuration
    
    init(configuration: Configuration) {
        self.configuration = configuration
    }
}

extension PersistentListProvider {
    
    struct Configuration {
        let documentsFileName: String
        let receiptsFileName: String
        let bundle: Bundle
        
        init(documentsFileName: String, receiptsFileName: String) {
            self.documentsFileName = documentsFileName
            self.receiptsFileName = receiptsFileName
            class __ { }
            self.bundle = Bundle(for: __.self)
        }
    }
}
