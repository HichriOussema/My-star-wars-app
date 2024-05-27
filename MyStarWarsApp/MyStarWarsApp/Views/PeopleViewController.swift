//
//  PeopleViewController.swift
//  MyStarWarsApp
//
//  Created by oussema Hichri on 23/05/2024.
//

import Foundation
import UIKit

class PeopleViewController: UIViewController {
  
  private let viewModel: PeopleViewModel
  
  init(viewModel: PeopleViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 20, height: 100)
    layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    title = "People"
    setupCollectionView()
    fetchData()
  }
  
  private func setupCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.prefetchDataSource = self
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
    //fetchData()
    self.collectionView.reloadData()
    self.collectionView.refreshControl?.endRefreshing()
  }
  
  private func fetchData() {
    print("Fetching initial data from VC", self.viewModel.people.count)
    viewModel.fetchPeople {
      DispatchQueue.main.async {
        self.collectionView.refreshControl?.endRefreshing()
        if self.viewModel.people.isEmpty {
          self.showErrorAlert()
        } else {
          self.collectionView.reloadData()
          print("Initial data loaded")
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

extension PeopleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    print("Number of items in section: \(viewModel.people.count)")
    return viewModel.people.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
    cell.configure(name: viewModel.people[indexPath.row].name)
    print("Configured cell for item at indexPath: \(indexPath)")
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let detailVC = DetailViewController()
    detailVC.person = viewModel.people[indexPath.row]
    navigationController?.pushViewController(detailVC, animated: true)
  }
}


extension PeopleViewController: UICollectionViewDataSourcePrefetching {
  func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    guard let maxIndex = indexPaths.map({ $0.row }).max() else { return }
    if maxIndex >= viewModel.people.count - 2 {
      print("Prefetching for index: \(indexPaths)")
      viewModel.fetchNextPage {
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      }
    }
  }
}
