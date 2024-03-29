//
//  PasswordCriteriaView.swift
//  Password
//
//  Created by Admin on 29/03/24.
//

import UIKit

class PasswordCriteriaView: UIView {
  
  let stackView = UIStackView()
  let imageView = UIImageView()
  let lable = UILabel()
  
  let checkMarkImage = UIImage(systemName: "checkmark.circle")!
    .withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
  let xMarkImage = UIImage(systemName: "xmark.circle")!
    .withTintColor(.systemRed, renderingMode: .alwaysOriginal)
  let circleImage = UIImage(systemName: "circle")!
    .withTintColor(.tertiaryLabel, renderingMode: .alwaysOriginal)
  
  var criteriaMet: ImageConfig = .reset {
    didSet {
      let image: UIImage
      
      switch criteriaMet {
      case .checkMark:
        image = checkMarkImage
      case .xMark:
        image = xMarkImage
      default:
        image = circleImage
      }
      
      imageView.image = image
    }
  }
  
  init(text: String) {
    super.init(frame: .zero)
    lable.text = text
    
    style()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var intrinsicContentSize: CGSize {
    return CGSize(width: 200, height: 40)
  }
  
  func reset() {
    criteriaMet = .reset
  }
}

extension PasswordCriteriaView {
  
  func style() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .systemCyan
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 8
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    reset()
    
    lable.translatesAutoresizingMaskIntoConstraints = false
    lable.font = .preferredFont(forTextStyle: .subheadline)
    lable.textColor = .secondaryLabel
  }
  
  func layout() {
    stackView.addArrangedSubview(imageView)
    stackView.addArrangedSubview(lable)
    
    addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
    ])
    
    // CHCR
    imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    lable.setContentHuggingPriority(.defaultLow, for: .horizontal)
  }
  
  enum ImageConfig {
    case checkMark
    case xMark
    case reset
  }
}
