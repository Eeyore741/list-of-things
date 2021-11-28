//
//  ListViewModelState.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-27.
//

import Foundation

enum ListViewModelState {
    case idle
    case busy
}

extension ListViewModelState: Equatable { }
