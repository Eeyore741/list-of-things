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
        
        self.tableView.backgroundColor = .red
        self.view.backgroundColor = .green
        self.tableView.backgroundView?.backgroundColor = .blue
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.self.description())
        
        self.fetchDocuments()
    }
    
    private func fetchDocuments() {
        Task {
            do {
                try await self.viewModel.fetchDocuments()
            }
            catch {
                
            }
        }
    }
    
//
//        Task {
//            await self.load()
//        }
    
//    func load() async {
//        let config = PersistentListProvider.Configuration(documentsFileName: "Documents", receiptsFileName: "Receipts")
//        let provider = PersistentListProvider(configuration: config)
//
//        do {
//            let docs = try await provider.fetchDocuments()
//            print(docs.description)
//        } catch {
//            fatalError()
//        }
//    }
}

extension ListViewController: UITableViewDelegate {
    
}

extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Section.documents:
            return self.viewModel.numberOfDocuments
        case Section.receipts:
            return self.viewModel.numberOfDocuments
        default:
            fatalError("Undefined section")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Section.documents:
            fatalError()
        case Section.receipts:
            fatalError()
        default:
            fatalError("Undefined section")
        }
    }
}

private extension ListViewController {
    
    enum Section {
        static var documents: Int { 0 }
        static var receipts: Int { 1 }
    }
}
