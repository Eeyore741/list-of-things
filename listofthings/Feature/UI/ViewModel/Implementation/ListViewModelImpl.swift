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
        
        self.documentsProvider.documentListProviderDelegate = self
    }
    
    weak var listViewModelDelegate: ListViewModelDelegate?
    
    var listViewModelState: ListViewModelState = .idle {
        didSet {
            guard self.listViewModelState != oldValue else { return }
            
            if self.listViewModelState == .idle { self.updateSectionsAndItems() }
            self.listViewModelDelegate?.listViewModelDelegateDidUpdateState(self)
        }
    }
    
    typealias Header = String
    var sections: [Header] = []
    var items: [Header: [ItemCell.Item]] = [:]
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        let header = self.items.keys.sorted()[section]
        guard let section = self.items[header] else { fatalError("Undefined section") }
        
        return section.count
    }
    
    var numberOfSections: Int {
        return self.sections.count
    }
    
    func fetchItems() {
        self.documentsProvider.fetchDocuments()
        self.receiptsProvider.fetchReceiptsWithOffset(0, andLimit: 0)
    }
    
    func fillCell(_ cell: ItemCell, atIndexPath indexPath: IndexPath) {
        let header = self.items.keys.sorted()[indexPath.section]
        guard let section = self.items[header] else { fatalError("Undefined section") }
        
        let item = section[indexPath.row]
        cell.item = item
    }
    
    func fillHeader(_ header: ListHeaderView, atIndex index: Int) {
        header.text = self.sections[index]
    }
}


// MARK: - Private helpers
private extension ListViewModelImpl {
    typealias ListViewModelItems = (documents: [Document], receipts: [Receipt])
    var availableItems: ListViewModelItems {
        switch (self.documentsProvider.documentListProviderState, self.receiptsProvider.receiptListProviderState) {
        case (.idle(.some(.success(let documents))), .idle(.some(.success(let receipts)))):
            return (documents, receipts)
        case (.idle(.some(.success(let documents))), _):
            return (documents, [])
        case (_, .idle(.some(.success(let receipts)))):
            return ([], receipts)
        default:
            return ([], [])
        }
    }
    
    static let sectionDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM YYYY"
        return dateFormatter
    }()
    
    func updateSectionsAndItems() {
//        self.availableItems.documents.forEach {
//            let header = Self.sectionDateFormatter.string(from: $0.createdAt)
//
//            if self.items.keys.contains(header) == false {
//                self.items[header] = []
//            }
//            self.items[header]?.append(ItemCell.Item.init(withDocument: $0))
//        }
        
//        self.sections = []
        var dates: [Date] = self.availableItems.documents.map { $0.createdAt }
        dates = dates + self.availableItems.receipts.map { $0.purchaseDate }
        dates.sort()
        dates.forEach {
            let header = Self.sectionDateFormatter.string(from: $0)
            if self.sections.contains(header) == false {
                self.sections.append(header)
            }
            if self.items.keys.contains(header) == false {
                self.items[header] = []
            }
        }
        
        self.availableItems.documents.forEach {
            let header = Self.sectionDateFormatter.string(from: $0.createdAt)
            self.items[header]?.append(ItemCell.Item.init(withDocument: $0))
        }
        self.availableItems.receipts.forEach {
            let header = Self.sectionDateFormatter.string(from: $0.purchaseDate)
            self.items[header]?.append(ItemCell.Item.init(withReceipt: $0))
        }
    }
}

// MARK: - DocumentListProviderDelegate conformace
extension ListViewModelImpl: DocumentListProviderDelegate {
    
    func documentListProviderDidUpdateState(_ provider: DocumentListProvider) {
        self.listViewModelState = ListViewModelState.makeWithDocumentListProviderState(self.documentsProvider.documentListProviderState, andReceiptListProviderState: self.receiptsProvider.receiptListProviderState)
    }
}

private extension ListViewModelState {
    
    static func makeWithDocumentListProviderState(_ dlpState: DocumentListProviderState, andReceiptListProviderState rlpState: ReceiptListProviderState) -> Self {
        switch (dlpState, rlpState) {
        case (.idle, .idle):
            return .idle
        default:
            return .busy
        }
    }
}

private extension ItemCell.Item {
    
    init(withDocument document: Document) {
        self.logo = document.logo
        self.title = document.subject
        self.subtitle = Self.dateFormatter.string(from: document.createdAt)
        self.info = document.senderName
    }
    
    init(withReceipt receipt: Receipt) {
        self.logo = receipt.logo
        self.title = receipt.storeName
        self.subtitle = Self.dateFormatter.string(from: receipt.purchaseDate)
        self.info = ""
    }
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter
    }()
}
