//
//  ListViewModelError.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-28.
//

import Foundation

enum ListViewModelError {
    case documents
    case receipts
}

extension ListViewModelError: Error { }
