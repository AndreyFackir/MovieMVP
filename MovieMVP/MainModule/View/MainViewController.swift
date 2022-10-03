//
//  ViewController.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 25.08.2022.
//

import UIKit

class MainViewController: UIViewController {
  
  var presenter: MainViewPresenterProtocol!
  private let header = "Header"
  
  enum Section: String, CaseIterable {
    case popular = "Popular Movies"
    case tvShows = "TV Shows"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    success()
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  //MARK: - Properties
  
  private let nameAppLable: UILabel = {
    let element = UILabel()
    element.text = "Movie"
    element.textColor = .white
    element.font = .specialAppName
    element.translatesAutoresizingMaskIntoConstraints = false
    var mutableString = NSMutableAttributedString()
    mutableString = NSMutableAttributedString(string: element.text ?? "")
    mutableString.addAttribute(NSMutableAttributedString.Key.foregroundColor,
                               value: UIColor.red,
                               range: NSRange(location: 3, length: 2))
    element.attributedText = mutableString
    return element
  }()
  
  private let collectionView: UICollectionView = {
    let layout = UICollectionViewCompositionalLayout { sectionNumber, env in
      let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)))
      item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(250)), subitems: [item])
      group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0)
      let section = NSCollectionLayoutSection(group: group)
      let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .estimated(44)),
        elementKind: UICollectionView.elementKindSectionHeader,
        alignment: .topLeading)
      
      sectionHeader.pinToVisibleBounds = true
      section.boundarySupplementaryItems = [sectionHeader]
      section.orthogonalScrollingBehavior = .continuous
      
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
extension MainViewController {
  private func setup() {
    setupViews()
    setConstraints()
  }
  
  private func setupViews() {
    view.backgroundColor = .specialBackground
    view.addSubview(nameAppLable)
    view.addSubview(collectionView)
    collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "idCell")
    collectionView.register(TitleSupplementaryView.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: header)
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  private func setConstraints() {
    NSLayoutConstraint.activate([
      nameAppLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
      nameAppLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
      
      collectionView.topAnchor.constraint(equalTo: nameAppLable.bottomAnchor, constant: 10),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -15)])
  }
}

//MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    Section.allCases.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
      case 0:
        return presenter.movies?.results.count ?? 0
      case 1:
        return presenter.serials?.results.count ?? 0
      default:
        return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idCell", for: indexPath) as? MainCollectionViewCell else { return .init()}
    let movies = presenter.movies?.results[indexPath.row]
    let serials = presenter.serials?.results[indexPath.row]
    let results = presenter.fetch()
    switch indexPath.section {
      case 0:
        for favourites in results {
          if favourites.id == movies?.id {
            cell.savedImage.image = UIImage(systemName: "heart.fill")
            cell.savedImage.tintColor = .red
          }
        }
        cell.footerLabel.text = movies?.originalTitle
        let convertedDate = presenter.convertedDateFormat(sourceString: movies?.releaseDate ?? "",
                                                          sourceFormat: "yyyy-MM-dd",
                                                          destinationFormat: "d MMM, yyyy")
        cell.dateOfReleaseLabel.text = convertedDate
        guard let imageUrl = movies?.posterPath else { return .init() }
        let fullImageUrl = Constants.posterUrl + imageUrl
        presenter.getImage(from: fullImageUrl) { image in
          DispatchQueue.main.async {
            cell.imageView.image = image
          }
        }
      default:
        for favourites in results {
          if favourites.id == serials?.id {
            cell.savedImage.image = UIImage(systemName: "heart.fill")
            cell.savedImage.tintColor = .red
          }
        }
        cell.footerLabel.text = serials?.name
        let convertedDate = presenter.convertedDateFormat(sourceString: serials?.firstAirDate ?? "",
                                                          sourceFormat: "yyyy-MM-dd",
                                                          destinationFormat: "d MMM, yyyy")
        cell.dateOfReleaseLabel.text = convertedDate
        guard let imageUrl = serials?.posterPath else { return .init() }
        let fullImageUrl = Constants.posterUrl + imageUrl
        presenter.getImage(from: fullImageUrl) { image in
          DispatchQueue.main.async {
            cell.imageView.image = image
          }
        }
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: header, for: indexPath) as! TitleSupplementaryView
    header.backgroundColor = .specialBackground
    header.headerLabel.text = Section.allCases[indexPath.section].rawValue
    return header
  }
  
  //MARK: - UICollectionViewDelegate
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let movie = presenter.movies?.results[indexPath.row]
    let serial = presenter.serials?.results[indexPath.row]
    
    switch indexPath.section {
      case 0:
        let detailVC = ModuleBuilder.createDetailModule(with: movie)
        navigationController?.pushViewController(detailVC, animated: true)
      default:
        let detailVC = ModuleBuilder.createDetailModule(with: serial)
        navigationController?.pushViewController(detailVC, animated: true)
    }
  }
}

//MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
  func success() {
    collectionView.reloadData()
  }
  
  func failure(error: Error) {
    print(error.localizedDescription)
  }
}
