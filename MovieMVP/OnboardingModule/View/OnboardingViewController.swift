//
//  OnboardingViewController.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 04.10.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  //MARK: - Properties
  
  private let nextButton: UIButton = {
    let element = UIButton(type: .system)
    element.translatesAutoresizingMaskIntoConstraints = false
    element.setTitle("Next", for: .normal)
    element.titleLabel?.font = .specialOnboardingFont
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
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalHeight(1), heightDimension: .fractionalWidth(1)), subitems: [item])
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .paging
      return section
    }
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.translatesAutoresizingMaskIntoConstraints = false
    collection.backgroundColor = .specialBackground
    collection.showsHorizontalScrollIndicator = false
    return collection
  }()
  
  //MARK: - Actions
  
  @objc private func nextButtonTapped() {
    print("nextButtonTapped")
  }
  
}

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
    onboardingCollection.delegate = self
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
      onboardingCollection.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20)
    ])
  }
}
//MARK: - UICollectionViewDataSource
extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    3
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingCell", for: indexPath) as? OnboardingCell else { return .init()}
    return cell
  }
}