//
//  ItemView.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-29.
//

import UIKit

final class ItemView: UIView {
    
    override static var requiresConstraintBasedLayout: Bool { true }
    
    var icon: String? {
        set {
            self.iconLabel.text = newValue
            self.iconLabel.isHidden = newValue == nil
        }
        get {
            self.iconLabel.text
        }
    }
    
    var title: String? {
        set {
            self.titleLabel.text = newValue
            self.titleLabel.isHidden = newValue == nil
        }
        get {
            self.titleLabel.text
        }
    }
    
    var subtitle: String? {
        set {
            self.subtitleLabel.text = newValue
            self.subtitleLabel.isHidden = newValue == nil
        }
        get {
            self.subtitleLabel.text
        }
    }
    
    var info: String? {
        set {
            self.infoLabel.text = newValue
            self.infoLabel.isHidden = newValue == nil
        }
        get {
            self.infoLabel.text
        }
    }
    
    private let iconLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32.0)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.numberOfLines = 3
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
        
        self.iconLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.infoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        [self.titleLabel, self.subtitleLabel, self.infoLabel].forEach { self.horizontalStack.addArrangedSubview($0) }
        self.addSubview(self.iconLabel)
        self.addSubview(self.horizontalStack)
        
        NSLayoutConstraint.activate([
            self.centerYAnchor.constraint(equalTo: self.iconLabel.centerYAnchor),
            self.leadingAnchor.constraint(equalTo: self.iconLabel.leadingAnchor),
            self.iconLabel.widthAnchor.constraint(equalToConstant: 30.0),
            self.iconLabel.heightAnchor.constraint(equalTo: self.iconLabel.widthAnchor),
            self.topAnchor.constraint(equalTo: self.horizontalStack.topAnchor),
            self.horizontalStack.leadingAnchor.constraint(equalTo: self.iconLabel.trailingAnchor, constant: 14.0),
            self.bottomAnchor.constraint(equalTo: self.horizontalStack.bottomAnchor),
            self.trailingAnchor.constraint(equalTo: self.horizontalStack.trailingAnchor),
        ])
        super.updateConstraints()
    }
}
