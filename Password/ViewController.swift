//
//  ViewController.swift
//  Password
//
//  Created by Admin on 29/03/24.
//

import UIKit

class ViewController: UIViewController {
  
  let stackView = UIStackView()
  let newPasswordTextField = PasswordTextField(pleaceHolderText: "New password")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    layout()
  }
}

extension ViewController {
  
  func style() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func layout() {
    stackView.addArrangedSubview(newPasswordTextField)
    view.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
    ])
  }
}
