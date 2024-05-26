//
//  SpeciesViewController.swift
//  MyStarWarsApp
//
//  Created by oussema Hichri on 23/05/2024.
//

import Foundation
import UIKit

class SpeciesViewController: UIViewController {
  
  private let viewModel = SpeciesViewModel()
  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    title = "Species"
    setupCollectionView()
    fetchData()
  }
  
  private func setupCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    view.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
    // Add Pull-to-Refresh
    collectionView.refreshControl = UIRefreshControl()
    collectionView.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
  }
  
  @objc private func reloadData() {
    fetchData()
  }
  
  private func fetchData() {
    viewModel.fetchSpecies {
      DispatchQueue.main.async {
        self.collectionView.refreshControl?.endRefreshing()
        if self.viewModel.species.isEmpty {
          self.showErrorAlert()
        } else {
          self.collectionView.reloadData()
        }
      }
    }
  }
  private func showErrorAlert() {
    let alert = UIAlertController(title: "Error", message: "Failed to load data. Please check your internet connection and try again.", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
      self.fetchData()
    }))
    present(alert, animated: true, completion: nil)
  }
}

extension SpeciesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.species.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath)as! CustomCell
    cell.configure(with: viewModel.species[indexPath.row].name)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let detailVC = DetailViewController()
    detailVC.species = viewModel.species[indexPath.row]
    navigationController?.pushViewController(detailVC, animated: true)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    if offsetY > contentHeight - scrollView.frame.height - 100 {
      viewModel.fetchNextPage {
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      }
    }
  }
}
