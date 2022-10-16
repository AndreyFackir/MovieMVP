//
//  OnboardingViewController.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 04.10.2022.
//

import UIKit


class OnboardingViewController: UIViewController {
  
  var presenter: OnboardingViewPresenterProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  //MARK: - Properties
  
  private let nextButton: UIButton = {
    let element = UIButton(type: .system)
    element.translatesAutoresizingMaskIntoConstraints = false
    element.setTitle("Next", for: .normal)
    element.titleLabel?.font = .robotoMedium20
    element.layer.cornerRadius = 25
    element.tintColor = .specialBackground
    element.backgroundColor = .white
    element.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    return element
  }()
  
  private let pageControl: UIPageControl = {
    let element = UIPageControl()
    element.translatesAutoresizingMaskIntoConstraints = false
    element.numberOfPages = 3
    element.isEnabled = false
    element.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    return element
  }()
  
  private let onboardingCollection: UICollectionView = {
    let layout = UICollectionViewCompositionalLayout { setionNumber, environ in
      let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [item])
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .paging
      return section
    }
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.translatesAutoresizingMaskIntoConstraints = false
    collection.backgroundColor = .black
    collection.showsHorizontalScrollIndicator = false
    collection.isUserInteractionEnabled = false
    return collection
  }()
  
  //MARK: - Actions
  
  @objc private func nextButtonTapped() {
    print("nextButtonTapped")
    presenter.nextButtontapped()
  }
}

// MARK: - Setup
extension OnboardingViewController {
  private func setup() {
    setupViews()
    setConstraints()
  }
  
  private func setupViews() {
    view.addSubview(nextButton)
    view.addSubview(pageControl)
    view.addSubview(onboardingCollection)
    onboardingCollection.register(OnboardingCell.self, forCellWithReuseIdentifier: "onboardingCell")
    onboardingCollection.dataSource = self
  }
  
  private func setConstraints() {
    NSLayoutConstraint.activate([
      nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
      nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
      nextButton.heightAnchor.constraint(equalToConstant: 50),
      
      pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20),
      
      onboardingCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
      onboardingCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
      onboardingCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
      onboardingCollection.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20)])
  }
}
//MARK: - UICollectionViewDataSource
extension OnboardingViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    presenter.configureScreens().count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingCell", for: indexPath) as? OnboardingCell else { return .init()}
    let model = presenter.configureScreens()[indexPath.row]
    cell.cellConfigure(model: model)
    return cell
  }
}

//MARK: - OnboardingViewProtocol
extension OnboardingViewController: OnboardingViewProtocol {
  func dismissVC() {
    dismiss(animated: true, completion: nil)
  }
  
  func nextButtontapped() {
    nextButton.setTitle("Let's Go", for: .normal)
  }
  
  func setPageControlCurrentPage(index: IndexPath, collectionItem: Int) {
    onboardingCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    pageControl.currentPage = collectionItem
  }
}
