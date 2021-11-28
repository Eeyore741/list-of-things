//
//  ReceiptType.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-16.
//

import Foundation

enum ReceiptType: String {
    case sale = "SALE"
    case `return` = "RETURN"
}

extension ReceiptType: Decodable { }
