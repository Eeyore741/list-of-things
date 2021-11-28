//
//  ListViewModel.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-17.
//

import UIKit

protocol ListViewModelDelegate: AnyObject {
    func listViewModelDelegateDidUpdateState(_ viewModel: ListViewModel)
}

protocol ListViewModel {
    var listViewModelState: ListViewModelState { get }
    var listViewModelDelegate: ListViewModelDelegate? { set get }
    var numberOfSections: Int { get }
    func numberOfItemsInSection(_ section: Int) -> Int
    func fetchItems()
    func fillCell(_ cell: ItemCell, atIndexPath indexPath: IndexPath)
    func fillHeader(_ header: ListHeaderView, atIndex index: Int)
}
