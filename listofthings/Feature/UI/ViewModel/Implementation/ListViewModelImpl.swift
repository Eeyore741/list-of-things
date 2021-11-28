//
//  ListViewModelImpl.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-27.
//

import UIKit

final class ListViewModelImpl: ListViewModel {
    
    private(set) var documentsProvider: DocumentListProvider
    private(set) var receiptsProvider: ReceiptListProvider
    
    init(documentsProvider: DocumentListProvider, receiptsProvider: ReceiptListProvider) {
        self.documentsProvider = documentsProvider
        self.receiptsProvider = receiptsProvider
    }
    
    var listViewModelState: ListViewModelState { .idle }
    
    var numberOfDocuments: Int = 0
    
    var numberOfReceipts: Int = 0
    
    func fetchDocuments() async throws {
        fatalError()
    }
    
    func fetchReceipts() async throws {
        fatalError()
    }
    
    func fillCell(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
        fatalError()
    }
}
