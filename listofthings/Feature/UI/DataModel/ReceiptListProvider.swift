//
//  ReceiptListProvider.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-27.
//

import Foundation

typealias ReceiptListProviderState = ListProviderState<Receipt>

protocol ReceiptListProviderDelegate: AnyObject {
    func receiptListProviderDidUpdateState(_ provider: ReceiptListProvider)
}

protocol ReceiptListProvider {
    var receiptListProviderState: ReceiptListProviderState { get }
    var receiptListProviderDelegate: ReceiptListProviderDelegate? { set get }
    func fetchReceiptsWithOffset(_ offset: Int, andLimit limit: Int)
}
