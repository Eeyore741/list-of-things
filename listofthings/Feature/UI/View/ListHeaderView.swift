//
//  ListHeaderView.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-29.
//

import UIKit

final class ListHeaderView: UITableViewHeaderFooterView {
    
    class override var requiresConstraintBasedLayout: Bool { true }
    
    var text: String? {
        set {
            self.headerView.text = newValue
        }
        get {
            self.headerView.text
        }
    }
    
    private var constraintsLayoutOnce: Bool = false
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func updateConstraints() {
        guard self.constraintsLayoutOnce == false else { return super.updateConstraints() }
        defer { self.constraintsLayoutOnce = true }
        
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.headerView)
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.headerView.topAnchor),
            self.contentView.readableContentGuide.leadingAnchor.constraint(equalTo: self.headerView.leadingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.headerView.bottomAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.headerView.trailingAnchor)
        ])
        super.updateConstraints()
    }
}
