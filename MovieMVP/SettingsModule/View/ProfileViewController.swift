//
//  File.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 12.09.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var presenter: ProfileViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewDidLayoutSubviews() {
        addPhotoImageView.layer.cornerRadius = addPhotoImageView.frame.height / 2
        
    }
    
    //MARK: - Properties
    private let addPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.7607843137, green: 0.7607843137, blue: 0.7607843137, alpha: 1)
        imageView.layer.borderWidth = 5
        
        imageView.image = UIImage(systemName: "person.crop.circle.badge.plus")
        
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let addPhotoView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialGreen
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let firstNameLabel = UILabel("First name")
    private let firstNameTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.clearButtonMode = .always
        element.backgroundColor = .specialBrown
        element.layer.cornerRadius = 10
        element.font = .robotoBold20
        element.textColor = .specialGray
        element.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: element.frame.height))
        element.leftViewMode = .always
        element.returnKeyType = .done
        return element
    }()
    
    private let secondNameLabel = UILabel("Second name")
    private let secondNameTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.clearButtonMode = .always
        element.backgroundColor = .specialBrown
        element.layer.cornerRadius = 10
        element.font = .robotoBold20
        element.textColor = .specialGray
        element.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: element.frame.height))
        element.leftViewMode = .always
        element.returnKeyType = .done
        return element
    }()
    
    
    //MARK: - Actions
    
}
//MARK: - Setup

private extension ProfileViewController {
    func setup() {
        setupViews()
        setConstraints()
        setupNavBar()
    }
    private func setupViews() {
        title = "Settings"
        view.backgroundColor = .specialBackground
        view.addSubview(addPhotoView)
        view.addSubview(addPhotoImageView)
        view.addSubview(firstNameLabel)
        view.addSubview(firstNameTextField)
        view.addSubview(secondNameLabel)
        view.addSubview(secondNameTextField)
    }
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            addPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            addPhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            addPhotoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            addPhotoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            addPhotoView.heightAnchor.constraint(equalToConstant: 100),
            addPhotoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addPhotoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            firstNameLabel.topAnchor.constraint(equalTo: addPhotoView.bottomAnchor, constant: 30),
            firstNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            
            firstNameTextField.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 5),
            firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 38),
            
            secondNameLabel.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 20),
            secondNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            
            secondNameTextField.topAnchor.constraint(equalTo: secondNameLabel.bottomAnchor, constant: 5),
            secondNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            secondNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            secondNameTextField.heightAnchor.constraint(equalToConstant: 38)])
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
//MARK: - ProfileViewProtocol
extension ProfileViewController: ProfileViewProtocol {
    
}
