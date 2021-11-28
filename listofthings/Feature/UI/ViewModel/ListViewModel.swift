//
//  ListViewModel.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-17.
//

import UIKit

protocol ListViewModel {
    var listViewModelState: ListViewModelState { get }
    var numberOfDocuments: Int { get }
    var numberOfReceipts: Int { get }
    func fetchDocuments() async throws
    func fetchReceipts() async throws
    func fillCell(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath)
}
