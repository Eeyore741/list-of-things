//
//  ItemCell.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-29.
//

import UIKit

final class ItemCell: UITableViewCell {
    
    class override var requiresConstraintBasedLayout: Bool { true }
    
    var item: Item? = nil {
        didSet {
            self.itemView.icon = self.item?.logo
            self.itemView.title = self.item?.title
            self.itemView.subtitle = self.item?.subtitle
            self.itemView.info = self.item?.info
        }
    }
    
    private var constraintsLayoutOnce: Bool = false
    private let itemView: ItemView = ItemView()
    
    override func updateConstraints() {
        guard self.constraintsLayoutOnce == false else { return super.updateConstraints() }
        defer { self.constraintsLayoutOnce = true }
        
        self.itemView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.itemView)
        
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.itemView.topAnchor),
            self.contentView.readableContentGuide.leadingAnchor.constraint(equalTo: self.itemView.leadingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.itemView.bottomAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.itemView.trailingAnchor)
        ])
        super.updateConstraints()
    }
}

extension ItemCell {
    
    struct Item {
        let logo: String
        let title: String
        let subtitle: String
        let info: String
    }
}
