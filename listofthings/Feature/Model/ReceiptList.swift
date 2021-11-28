//
//  ReceiptList.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-17.
//

import Foundation

struct ReceiptList {
    let total: Int
    let offset: Int
    let limit: Int
    let receipts: [Receipt]
}

extension ReceiptList: Decodable { }
