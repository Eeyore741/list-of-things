//
//  Receipt.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-16.
//

import Foundation

struct Receipt {
    let type: ReceiptType
    let storeName: String
    let purchaseDate: Date
    let logo: String = "🧾"
}

extension Receipt: Decodable { }
