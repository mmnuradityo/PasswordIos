//
//  PasswordTextField.swift
//  Password
//
//  Created by Admin on 29/03/24.
//
import UIKit

protocol PasswordTextFieldDelegate: AnyObject {
  func editingChanged(_ sender: PasswordTextField)
  func editingDidEnd(_ sender: PasswordTextField)
}

class PasswordTextField: UIView {
  
  /**
   A function one passes in to do custom validation on the text field.
   
   - Parameter: textValue: The value of text to validate
   - Returns: A Bool indicating whether text is valid, and if not a String containing an error message
   */
  typealias CustomValidation = (_ textValue: String?) -> (Bool, String)?
  
  // ui component
  let lockImageView = UIImageView(image: UIImage(systemName: "lock.fill"))
  let textField = UITextField()
  let eyeButton = UIButton(type: .custom)
  let dividerView = UIView()
  let errorLable = UILabel()
  
  // variable
  let pleaceHolderText: String
  var customValidation: CustomValidation?
  weak var delegate: PasswordTextFieldDelegate?
  
  var text: String? {
    get { textField.text }
    set { textField.text = newValue }
  }
  
  init(pleaceHolderText: String) {
    self.pleaceHolderText = pleaceHolderText
    super.init(frame: .zero)
    
    style()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var intrinsicContentSize: CGSize {
    return CGSize(width: 200, height: 60)
  }
}

extension PasswordTextField {
  
  func style() {
    translatesAutoresizingMaskIntoConstraints = false
    
    lockImageView.translatesAutoresizingMaskIntoConstraints = false
    
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.isSecureTextEntry = false
    textField.placeholder = pleaceHolderText
    textField.delegate = self
    textField.keyboardType = .asciiCapable
    textField.attributedPlaceholder = NSAttributedString(
      string: pleaceHolderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
    )
    // extra interaction
    textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    
    eyeButton.translatesAutoresizingMaskIntoConstraints = false
    eyeButton.setImage(UIImage(systemName: "eye.circle"), for: .normal)
    eyeButton.setImage(UIImage(systemName: "eye.slash.circle"), for: .selected)
    eyeButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
    
    dividerView.translatesAutoresizingMaskIntoConstraints = false
    dividerView.backgroundColor = .separator
    
    errorLable.translatesAutoresizingMaskIntoConstraints = false
    errorLable.textColor = .systemRed
    errorLable.font = .preferredFont(forTextStyle: .footnote)
    errorLable.text = "Your password must meet the requirement below."
    errorLable.numberOfLines = 0
    errorLable.lineBreakMode = .byWordWrapping
    errorLable.isHidden = true
  }
  
  func layout() {
    addSubview(lockImageView)
    addSubview(textField)
    addSubview(eyeButton)
    addSubview(dividerView)
    addSubview(errorLable)
    
    NSLayoutConstraint.activate([
      lockImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      lockImageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
      
      textField.leadingAnchor.constraint(equalToSystemSpacingAfter: lockImageView.trailingAnchor, multiplier: 1),
      textField.topAnchor.constraint(equalTo: topAnchor),
      
      eyeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 1),
      eyeButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
      eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      dividerView.heightAnchor.constraint(equalToConstant: 1),
      dividerView.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 1),
      dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      errorLable.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 4),
      errorLable.leadingAnchor.constraint(equalTo: leadingAnchor),
      errorLable.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
    
    // CHCR
    lockImageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
    textField.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
    eyeButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
  }
}

// MARK: Action
extension PasswordTextField {
  @objc func togglePasswordView(_ sender: UIButton) {
    textField.isSecureTextEntry.toggle()
    eyeButton.isSelected.toggle()
  }
  
  @objc func textFieldEditingChanged(_ sender: UITextField) {
    delegate?.editingChanged(self)
  }
}

extension PasswordTextField: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    delegate?.editingDidEnd(self)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    print("foo - teShouldReturn : \(String(describing: textField.text))")
    textField.endEditing(true)
    return true
  }
}

// typealias CustomValidation = (_ textValue: String?) -> (Bool, String)?

// MARK: - Validation
extension PasswordTextField {
  func validate() -> Bool {
    if let customValidation = customValidation,
       let customValidationResult = customValidation(text),
       customValidationResult.0 == false {
      showError(customValidationResult.1)
      return false
    }
    
    clearError()
    return true
  }
  
  func showError(_ errorMessage: String) {
    errorLable.text = errorMessage
    errorLable.isHidden = false
  }
  
  func clearError() {
    errorLable.text = ""
    errorLable.isHidden = true
  }
}
