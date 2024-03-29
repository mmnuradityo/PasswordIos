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
  let statusView = PassworStatusView()
  let confirmPasswordTextField = PasswordTextField(pleaceHolderText: "Re-enter new password")
  let resetButton = UIButton(type: .system)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    layout()
  }
}

extension ViewController {
  
  func style() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 20
    
    newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
    
    statusView.translatesAutoresizingMaskIntoConstraints = false
    stackView.layer.cornerRadius = 5
    stackView.clipsToBounds = true
    
    confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
    
    resetButton.translatesAutoresizingMaskIntoConstraints = false
    resetButton.configuration = .filled()
    resetButton.setTitle("Reset password", for: [])
    resetButton.addTarget(
      self, action: #selector(resetPasswordButtonTapped), for: .primaryActionTriggered
    )
  }
  
  func layout() {
    stackView.addArrangedSubview(newPasswordTextField)
    stackView.addArrangedSubview(statusView)
    stackView.addArrangedSubview(confirmPasswordTextField)
    stackView.addArrangedSubview(resetButton)
    
    view.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
    ])
  }
}


// MARK: Action
extension ViewController {
  @objc func resetPasswordButtonTapped(_ sender: UIButton) {
    
  }
}
