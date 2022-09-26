//
//  DetailViewController.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 27.08.2022.
//

import UIKit

class DetailViewController: UIViewController {
  var presenter: DetailViewPresenterProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    presenter.setDetails()
  }
  
  
  
  //MARK: - Properties
  
  private lazy var scrollView: UIScrollView = {
    let scroll = UIScrollView()
    scroll.translatesAutoresizingMaskIntoConstraints = false
    return scroll
  }()
  
  private lazy var containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let mainImage: UIImageView = {
    let element = UIImageView()
    element.translatesAutoresizingMaskIntoConstraints = false
    element.image = UIImage(systemName: "film.stack")
    element.contentMode = .scaleAspectFit
    element.clipsToBounds = true
    return element
  }()
  
  let yearStyleTimeLabel: UILabel = {
    let element = UILabel()
    element.translatesAutoresizingMaskIntoConstraints = false
    element.textColor = .specialDesription
    element.font = .specialDescription
    element.text = "2020 • Adventure, Action • 2 h 35 min"
    return element
  }()
  
  let filmDescription: UILabel = {
    let element = UILabel()
    element.translatesAutoresizingMaskIntoConstraints = false
    element.text = "Wonder Woman squares off against Maxwell Lord and the Cheetah, a villainess who possesses superhuman strength and guilty"
    element.textColor = .specialDesription
    element.font = .specialDescription
    element.numberOfLines = 0
    return element
  }()
  
  let castLabel: UILabel = {
    let element = UILabel()
    element.translatesAutoresizingMaskIntoConstraints = false
    element.text = "Cast"
    element.textColor = .white
    element.font = .specialDescription
    return element
  }()
  
  private let castCollection: UICollectionView = {
    let layout = UICollectionViewCompositionalLayout { section, env  in
      let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1),
        heightDimension: .fractionalHeight(1)))
      
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
        widthDimension: .absolute(70),
        heightDimension: .absolute(70)), subitems: [item])
      
      let section = NSCollectionLayoutSection(group: group)
      section.interGroupSpacing = 10
      section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
      section.orthogonalScrollingBehavior = .continuous
      return section
    }
    
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.translatesAutoresizingMaskIntoConstraints = false
    collection.showsHorizontalScrollIndicator = false
    collection.alwaysBounceVertical = false
    collection.backgroundColor = .specialBackground
    return collection
    
  }()
  
  private lazy var watchButton: UIButton = {
    let element = UIButton()
    element.translatesAutoresizingMaskIntoConstraints = false
    element.setTitle("Watch now", for: .normal)
    element.backgroundColor = .specialTabBar
    element.setTitleColor(.white, for: .normal)
    element.layer.cornerRadius = 10
    // element.addTarget(self, action: #selector(watchButtonTapped), for: .touchUpInside)
    return element
  }()
}


// MARK: - CollectionView
extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    presenter.serialAndMovieCast?.cast.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailCell", for: indexPath) as? DetailCell else { return .init() }
    
    let cast = presenter.serialAndMovieCast?.cast[indexPath.row]
    cell.actorRole.text = cast?.character
    cell.actorRealName.text = cast?.name
    guard let imageUrl = cast?.profilePath else { return .init()}
    let actorFullImage = Constants.posterUrl + imageUrl
    presenter.getImage(from: actorFullImage) { image in
      DispatchQueue.main.async {
        cell.actorImage.image = image
        cell.actorImage.layer.cornerRadius = cell.frame.width / 2
        cell.actorImage.clipsToBounds = true
      }
    }
    return cell
  }
}

// MARK: - Setup
private extension DetailViewController {
  func setup() {
    setupNavigationBar()
    setupViews()
    setupConstraints()
  }
  
  func setupNavigationBar() {
    let coloredAppearance = UINavigationBarAppearance()
    coloredAppearance.configureWithOpaqueBackground()
    coloredAppearance.backgroundColor = .specialBackground
    coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    
    navigationController?.navigationBar.standardAppearance = coloredAppearance
    navigationController?.navigationBar.scrollEdgeAppearance = coloredAppearance
    navigationController?.navigationBar.tintColor = .white
    
    let heartImage = UIBarButtonItem(image: nil, style: .plain, target: self, action: nil)
    heartImage.image = UIImage(systemName: "heart")
    heartImage.tintColor = .white
    navigationController?.topViewController?.navigationItem.rightBarButtonItem = heartImage
  }
  
  func setupViews() {
    view.backgroundColor = .specialBackground
    castCollection.register(DetailCell.self, forCellWithReuseIdentifier: "detailCell")
    castCollection.dataSource = self
    castCollection.delegate = self
    view.addSubview(scrollView)
    scrollView.addSubview(containerView)
    containerView.addSubview(mainImage)
    containerView.addSubview(yearStyleTimeLabel)
    containerView.addSubview(filmDescription)
    containerView.addSubview(castLabel)
    containerView.addSubview(castCollection)
    containerView.addSubview(watchButton)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      
      scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
      
      containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
      containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
      containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
      containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
      containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      containerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1.2),
      
      mainImage.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 0),
      mainImage.heightAnchor.constraint(equalTo: containerView.widthAnchor),
      mainImage.widthAnchor.constraint(equalTo: containerView.widthAnchor),
      
      yearStyleTimeLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      yearStyleTimeLabel.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 10),
      
      filmDescription.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
      filmDescription.topAnchor.constraint(equalTo: yearStyleTimeLabel.bottomAnchor, constant: 30),
      filmDescription.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
      
      castLabel.topAnchor.constraint(equalTo: filmDescription.bottomAnchor, constant: 20),
      castLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
      
      castCollection.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: 15),
      castCollection.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
      castCollection.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
      castCollection.heightAnchor.constraint(equalToConstant: 170),
      
      watchButton.topAnchor.constraint(equalTo: castCollection.bottomAnchor, constant: 20),
      watchButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      watchButton.widthAnchor.constraint(equalTo: containerView.widthAnchor),
      watchButton.heightAnchor.constraint(equalToConstant: 60)])
  }
}

//MARK: - DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
  
  func setDetails(movie: Movies?, serial: TVShows?) {
    if movie == nil {
        filmDescription.text = serial?.overview
        yearStyleTimeLabel.text = "Release - \(serial?.firstAirDate ?? "")"
        guard let imageUrl = serial?.posterPath else { return }
        let fullImageUrl = Constants.posterUrl + imageUrl
        presenter.getImage(from: fullImageUrl) { image in
          DispatchQueue.main.async {
            self.mainImage.image = image
          }
        }
    } else {
      filmDescription.text = movie?.overview
      yearStyleTimeLabel.text = "Release - \(movie?.releaseDate ?? "")"
      guard let imageUrl = movie?.posterPath else { return }
      let fullImageUrl = Constants.posterUrl + imageUrl
      presenter.getImage(from: fullImageUrl) { image in
        DispatchQueue.main.async {
          self.mainImage.image = image
        }
      }
    }
  }
  
  func success() {
    castCollection.reloadData()
  }
  
  func failure(error: Error) {
    print(error.localizedDescription)
  }
  
 
  
}
