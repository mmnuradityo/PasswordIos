//
//  PasswordCriteria.swift
//  Password
//
//  Created by Admin on 05/04/24.
//

import Foundation

struct PasswordCriteria {
  static func lenghtCriteriaMet(_ text: String) -> Bool {
    text.count >= 8 && text.count <= 32
  }
  
  static func noSpaceCriteria(_ text: String) -> Bool {
    text.rangeOfCharacter(from: NSCharacterSet.whitespaces) == nil
  }
  
  static func lengthAndNoSpaceCriteriaMet(_ text: String) -> Bool {
    lenghtCriteriaMet(text) && noSpaceCriteria(text)
  }
  
  static func upperCaseCriteriaMet(_ text: String) -> Bool {
    text.range(of: "[A-Z]+", options: .regularExpression) != nil
  }
  
  static func lowerCaseCriteriaMet(_ text: String) -> Bool {
    text.range(of: "[a-z]+", options: .regularExpression) != nil
  }
  
  static func digitMet(_ text: String) -> Bool {
    text.range(of: "[0-9]+", options: .regularExpression) != nil
  }
  
  static func specialCharacterMet(_ text: String) -> Bool {
    text.range(of: "[@:?!()$#,./\\\\]+", options: .regularExpression) != nil
  }
}
