//
//  PassworStatusView.swift
//  Password
//
//  Created by Admin on 29/03/24.
//
import UIKit

class PassworStatusView: UIView {
  
  let stackView = UIStackView()
  
  let criteriaLable = UILabel()
  
  let lengthCriteriaView = PasswordCriteriaView(text: "8-32 characters (no spaces)")
  let uppercaseCriteriaView = PasswordCriteriaView(text: "uppercase letter (A-Z)")
  let lowerCaseCriteriaView = PasswordCriteriaView(text: "lowercase (a-z)")
  let digitCriteriaView = PasswordCriteriaView(text: "digit (0-9)")
  let specialCharacterCriteriaView = PasswordCriteriaView(text: "special character (e.g. !@#$%^)")
  
  // Use to determine if we reset criteria back to empty state.
  private var shouldResetCriteria = true
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    style()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var intrinsicContentSize: CGSize {
    return CGSize(width: 200, height: 200)
  }
}

extension PassworStatusView {
  
  func style() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .tertiarySystemFill
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 8
    stackView.axis = .vertical
    stackView.distribution = .equalCentering
    
    criteriaLable.numberOfLines = 0
    criteriaLable.lineBreakMode = .byWordWrapping
    criteriaLable.attributedText = makeCriteriaMessage()
    
    lengthCriteriaView.translatesAutoresizingMaskIntoConstraints = false
    uppercaseCriteriaView.translatesAutoresizingMaskIntoConstraints = false
    lowerCaseCriteriaView.translatesAutoresizingMaskIntoConstraints = false
    digitCriteriaView.translatesAutoresizingMaskIntoConstraints = false
    specialCharacterCriteriaView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func layout() {
    stackView.addArrangedSubview(lengthCriteriaView)
    stackView.addArrangedSubview(criteriaLable)
    stackView.addArrangedSubview(uppercaseCriteriaView)
    stackView.addArrangedSubview(lowerCaseCriteriaView)
    stackView.addArrangedSubview(digitCriteriaView)
    stackView.addArrangedSubview(specialCharacterCriteriaView)
    
    addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
      stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
      trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
      bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 2)
    ])
  }
  
  private func makeCriteriaMessage() -> NSAttributedString {
      var plainTextAttributes = [NSAttributedString.Key: AnyObject]()
      plainTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)
      plainTextAttributes[.foregroundColor] = UIColor.secondaryLabel
      
      var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
      boldTextAttributes[.foregroundColor] = UIColor.label
      boldTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)

      let attrText = NSMutableAttributedString(string: "Use at least ", attributes: plainTextAttributes)
      attrText.append(NSAttributedString(string: "3 of these 4 ", attributes: boldTextAttributes))
      attrText.append(NSAttributedString(string: "criteria when setting your password:", attributes: plainTextAttributes))

      return attrText
  }
}


// MARK: action
extension PassworStatusView {
  func updateDisplay(_ text: String) {
    let lenghtAndNoSpaceMet = PasswordCriteria.lengthAndNoSpaceCriteriaMet(text)
    let upperCaseMet = PasswordCriteria.upperCaseCriteriaMet(text)
    let loweCaseMet = PasswordCriteria.lowerCaseCriteriaMet(text)
    let digitMet = PasswordCriteria.digitMet(text)
    let specialCharacterMet = PasswordCriteria.specialCharacterMet(text)
    
    if shouldResetCriteria {
      // Inline validation
      lenghtAndNoSpaceMet
        ? lengthCriteriaView.criteriaMet = .checkMark
        : lengthCriteriaView.reset()
      upperCaseMet 
        ? uppercaseCriteriaView.criteriaMet = .checkMark
        : uppercaseCriteriaView.reset()
      
      loweCaseMet
        ? lowerCaseCriteriaView.criteriaMet = .checkMark
        : lowerCaseCriteriaView.reset()
      
      digitMet
        ? digitCriteriaView.criteriaMet = .checkMark
        : digitCriteriaView.reset()
      
      specialCharacterMet
        ? specialCharacterCriteriaView.criteriaMet = .checkMark
        : specialCharacterCriteriaView.reset()
    }
  }
}
