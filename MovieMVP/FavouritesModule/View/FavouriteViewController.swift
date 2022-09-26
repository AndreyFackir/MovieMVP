//
//  FavouriteViewController.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 12.09.2022.
//

import UIKit

class FavouriteViewController: UIViewController {
  var presenter: FavouritesViewPresenterProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    
  }
  
  //MARK: - Properties
  
  private let favouriteCollection: UICollectionView = {
    let layout = UICollectionViewCompositionalLayout { section, environ in
      
      let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(0.33),
        heightDimension: .fractionalHeight(1)))
      item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 10)
      
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
      
      let section = NSCollectionLayoutSection(group: group)
      return section
    }
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.translatesAutoresizingMaskIntoConstraints = false
    collection.showsVerticalScrollIndicator = false
    collection.backgroundColor = .specialBackground
    return collection
  }()
  
  
  
}
//MARK: - Setup
private extension FavouriteViewController {
  func setup() {
    setupViews()
    setConstraints()
    setupNavBar()
  }
  private func setupViews() {
    view.backgroundColor = .specialBackground
    view.addSubview(favouriteCollection)
    favouriteCollection.dataSource = self
    favouriteCollection.register(FavouriteCell.self, forCellWithReuseIdentifier: "favouriteCell")
    title = "Favourites"
  }
  
  private func setConstraints() {
    NSLayoutConstraint.activate([
      favouriteCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
      favouriteCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      favouriteCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
      favouriteCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)])
  }
  
  private func setupNavBar() {
    let coloredAppearance = UINavigationBarAppearance()
    coloredAppearance.configureWithOpaqueBackground()
    coloredAppearance.backgroundColor = .specialBackground
    coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    navigationController?.navigationBar.standardAppearance = coloredAppearance
    navigationController?.navigationBar.scrollEdgeAppearance = coloredAppearance
    navigationController?.navigationBar.tintColor = UIColor.white
  }
}

//MARK: - UICollectionViewDataSource

extension FavouriteViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favouriteCell", for: indexPath) as? FavouriteCell else { return .init() }
    cell.backgroundColor = .blue
    return cell
  }
  
  
}
//MARK: - FavouritesViewProtocol
extension FavouriteViewController: FavouritesViewProtocol {
  func success() {
    print("FAFA")
  }
  
  func failure(error: Error) {
    print(error.localizedDescription)
  }
  
  
}
