//
//  ReceiptListProvider.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-27.
//

import Foundation

protocol ReceiptListProvider {
    func fetchReceiptsWithOffset(_ offset: Int, andLimit limit: Int) async throws -> ReceiptList
}
