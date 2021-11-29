//
//  HeaderView.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-29.
//

import UIKit

final class HeaderView: UIView {
    
    override static var requiresConstraintBasedLayout: Bool { true }
    
    var text: String? {
        set {
            self.label.text = newValue
        }
        get {
            self.label.text
        }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        return label
    }()
    
    private var constraintsLayoutOnce: Bool = false
    
    override func updateConstraints() {
        guard self.constraintsLayoutOnce == false else { return super.updateConstraints() }
        defer { self.constraintsLayoutOnce = true}
        
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.label)
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: self.label.leadingAnchor),
            self.bottomAnchor.constraint(equalTo: self.label.bottomAnchor)
        ])
        super.updateConstraints()
    }
}
