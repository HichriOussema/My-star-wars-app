//
//  CustomCell.swift
//  MyStarWarsApp
//
//  Created by oussema Hichri on 26/05/2024.
//

import Foundation
import UIKit

class CustomCell: UICollectionViewCell {
    static let identifier = "CustomCell"
    
    private let customView = CustomView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with name: String) {
        customView.configure(with: name)
    }
}
