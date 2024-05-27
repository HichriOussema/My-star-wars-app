//
//  CustomView.swift
//  MyStarWarsApp
//
//  Created by oussema Hichri on 26/05/2024.
//

import Foundation
import UIKit

class CustomView: UIView {
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let classificationLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    label.isHidden = true  // Hide by default
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    addSubview(nameLabel)
    addSubview(classificationLabel)
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: topAnchor),
      nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      classificationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
      classificationLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      classificationLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      classificationLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  func configure(name: String, classification: String? = nil) {
    nameLabel.text = name
    if let classification = classification {
      classificationLabel.text = classification
      classificationLabel.isHidden = false
    } else {
      classificationLabel.isHidden = true
    }
  }
}
