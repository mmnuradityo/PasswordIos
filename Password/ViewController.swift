//
//  ViewController.swift
//  Password
//
//  Created by Admin on 29/03/24.
//

import UIKit

class ViewController: UIViewController {
  
  typealias CustomValidation = PasswordTextField.CustomValidation
  
  let stackView = UIStackView()
  let newPasswordTextField = PasswordTextField(pleaceHolderText: "New password")
  let statusView = PassworStatusView()
  let confirmPasswordTextField = PasswordTextField(pleaceHolderText: "Re-enter new password")
  let resetButton = UIButton(type: .system)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    style()
    layout()
  }
}

extension ViewController {
  
  func setup() {
    setupNewPassword()
    setupConfirmPassword()
    setupDismissKeyboardGesture()
  }
  
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

extension ViewController {
  private func setupNewPassword() {
    let newPasswordValidation: CustomValidation = { text in
      
      func resetWith(message: String) -> (Bool, String)? {
        self.statusView.reset()
        return (false, message)
      }
      
      // Empty text
      guard let text = text, !text.isEmpty else {
        return resetWith(message: "Enter your password")
      }
      
      // Valid characters
      let validChars = "abcdefghijklmnopqrstuvwxyz"
      + "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
      + "0123456789"
      + ".,@:?!()$\\/#"
      
      let invalidSet = CharacterSet(charactersIn: validChars).inverted
      guard text.rangeOfCharacter(from: invalidSet) == nil else {
        return resetWith(message: "Enter valid special chars (.,@:?!()$\\/#) with no spaces")
      }
      
      // Criteria met
      self.statusView.updateDisplay(text)
      if !self.statusView.validate(text) {
        return (false, "Your password must meet the requirements below")
      }
      
      return (true, "")
    }
    
    newPasswordTextField.customValidation = newPasswordValidation
    newPasswordTextField.delegate = self
  }
  
  func setupConfirmPassword() {
    let confimPasswordValidation: CustomValidation = { text in
      guard let text = text, !text.isEmpty else {
        return (false, "Enter your password")
      }
      
      guard text == self.newPasswordTextField.text else {
        return (false, "Passwords do not match")
      }
      
      return (true, "")
    }
    
    confirmPasswordTextField.customValidation = confimPasswordValidation
    confirmPasswordTextField.delegate = self
  }
  
  private func setupDismissKeyboardGesture() {
    let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_ : )))
    view.addGestureRecognizer(dismissKeyboardTap)
  }
}

// MARK: Action
extension ViewController {
  @objc func resetPasswordButtonTapped(_ sender: UIButton) {
    
  }
  
  @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
    view.endEditing(true) // resign first responder
  }
}

// MARK: PasswordTextFieldDelegate
extension ViewController: PasswordTextFieldDelegate {
  func editingChanged(_ sender: PasswordTextField) {
    if sender === newPasswordTextField {
      statusView.updateDisplay(sender.textField.text ?? "")
    }
  }
  
  func editingDidEnd(_ sender: PasswordTextField) {
    if sender === newPasswordTextField {
      // as soon as we lose focus, make ❌ appear
      statusView.shouldResetCriteria = false
      _ = newPasswordTextField.validate()
    } else if sender == confirmPasswordTextField {
      _ = confirmPasswordTextField.validate()
    }
  }
}
