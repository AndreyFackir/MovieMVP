//
//  WebViewViewController.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 26.09.2022.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
  
  var presenter: WebViewPresenterProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    presenter.makeRequest()
  }
  
  //MARK: - Properties
  private let webView: WKWebView = {
    let element = WKWebView()
    element.translatesAutoresizingMaskIntoConstraints = false
    return element
  }()
}

//MARK: - Setup
private extension WebViewViewController {
  private func setup() {
    setupViews()
    setConstraints()
  }
  
  private func setupViews() {
    view.addSubview(webView)
  }
  
  private func setConstraints() {
    NSLayoutConstraint.activate([
      webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
      webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
      webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
      webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)])
  }
}

//MARK: - WebViewProtocol
extension WebViewViewController: WebViewProtocol {
  
  func makeRequest(with url: String) {
    guard let url = URL(string: url) else { return }
    let request = URLRequest(url: url)
    webView.load(request)
  }
}
