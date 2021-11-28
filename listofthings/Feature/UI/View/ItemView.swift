//
//  ItemView.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-29.
//

import UIKit

final class ItemView: UIView {
    
    override static var requiresConstraintBasedLayout: Bool { true }
    
    var title: String? {
        set {
            self.titleLabel.text = newValue
        }
        get {
            self.titleLabel.text
        }
    }
    
    var subtitle: String? {
        set {
            self.subtitleLabel.text = newValue
        }
        get {
            self.subtitleLabel.text
        }
    }
    
    var info: String? {
        set {
            self.infoLabel.text = newValue
        }
        get {
            self.infoLabel.text
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        return label
    }()
    
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.vertical
        stack.alignment = UIStackView.Alignment.leading
        return stack
    }()
    
    private var constraintsLayoutOnce: Bool = false
    
    override func updateConstraints() {
        guard self.constraintsLayoutOnce == false else { return super.updateConstraints() }
        defer { self.constraintsLayoutOnce = true}
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.infoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        [self.titleLabel, self.subtitleLabel, self.infoLabel].forEach { self.horizontalStack.addArrangedSubview($0) }
        self.addSubview(self.horizontalStack)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: self.horizontalStack.topAnchor),
            self.leadingAnchor.constraint(equalTo: self.horizontalStack.leadingAnchor),
            self.bottomAnchor.constraint(equalTo: self.horizontalStack.bottomAnchor),
            self.trailingAnchor.constraint(equalTo: self.horizontalStack.trailingAnchor),
        ])
        super.updateConstraints()
    }
}
