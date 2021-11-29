//
//  ListViewController.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-16.
//

import UIKit

final class ListViewController: UIViewController {
    
    private let tableView: UITableView
    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        self.tableView = UITableView()
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.listViewModelDelegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) var viewModel: ListViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        self.tableView.dataSource = self
        self.tableView.register(ItemCell.self, forCellReuseIdentifier: ItemCell.self.description())
        self.tableView.register(ListHeaderView.self, forHeaderFooterViewReuseIdentifier: ListHeaderView.self.description())
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 70.0
        self.tableView.sectionHeaderHeight = UITableView.automaticDimension
        
        self.viewModel.fetchItems()
    }
    
    private func updateListContent() {
        self.tableView.reloadData()
    }
}

extension ListViewController: ListViewModelDelegate {
    
    func listViewModelDelegateDidUpdateState(_ viewModel: ListViewModel) {
        switch viewModel.listViewModelState {
        case .idle:
            self.updateListContent()
        case .busy:
            break // show activity indicator
        }
    }
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ListHeaderView.self.description()) as? ListHeaderView else { fatalError("Unexpected view type") }
        
        self.viewModel.fillHeader(header, atIndex: section)
        return header
    }
}

extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.numberOfItemsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.self.description(), for: indexPath) as? ItemCell else { fatalError("Unexpected cell type") }
        
        self.viewModel.fillCell(cell, atIndexPath: indexPath)
        return cell
    }
}
