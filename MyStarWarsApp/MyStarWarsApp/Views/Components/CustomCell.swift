//
//  CustomCell.swift
//  MyStarWarsApp
//
//  Created by oussema Hichri on 26/05/2024.
//

import UIKit

class CustomCell: UICollectionViewCell {
  static let identifier = "CustomCell"
  
  private let customView = CustomView()
  private let separatorView = UIView()
  private let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    contentView.layer.cornerRadius = 10
    contentView.layer.masksToBounds = true
    contentView.layer.borderColor = UIColor.lightGray.cgColor
    contentView.layer.borderWidth = 1
    
    setupVisualEffectView()
    setupCustomView()
    setupSeparatorView()
    setupShadow()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupVisualEffectView() {
    visualEffectView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(visualEffectView)
    NSLayoutConstraint.activate([
      visualEffectView.topAnchor.constraint(equalTo: contentView.topAnchor),
      visualEffectView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      visualEffectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      visualEffectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
  }
  
  private func setupCustomView() {
    customView.translatesAutoresizingMaskIntoConstraints = false
    visualEffectView.contentView.addSubview(customView)
    NSLayoutConstraint.activate([
      customView.topAnchor.constraint(equalTo: visualEffectView.contentView.topAnchor, constant: 10),
      customView.bottomAnchor.constraint(equalTo: visualEffectView.contentView.bottomAnchor, constant: -10),
      customView.leadingAnchor.constraint(equalTo: visualEffectView.contentView.leadingAnchor, constant: 10),
      customView.trailingAnchor.constraint(equalTo: visualEffectView.contentView.trailingAnchor, constant: -10)
    ])
  }
  
  private func setupSeparatorView() {
    separatorView.backgroundColor = UIColor.lightGray
    separatorView.translatesAutoresizingMaskIntoConstraints = false
    visualEffectView.contentView.addSubview(separatorView)
    NSLayoutConstraint.activate([
      separatorView.leadingAnchor.constraint(equalTo: visualEffectView.contentView.leadingAnchor, constant: 10),
      separatorView.trailingAnchor.constraint(equalTo: visualEffectView.contentView.trailingAnchor, constant: -10),
      separatorView.bottomAnchor.constraint(equalTo: visualEffectView.contentView.bottomAnchor),
      separatorView.heightAnchor.constraint(equalToConstant: 1)
    ])
  }
  
  private func setupShadow() {
    contentView.layer.shadowColor = UIColor.black.cgColor
    contentView.layer.shadowOpacity = 0.2
    contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
    contentView.layer.shadowRadius = 4
    contentView.layer.masksToBounds = false
  }
  
  func configure(name: String, classification: String? = nil) {
    customView.configure(name: name, classification: classification)
  }
}

