//
//  ViewControllerTests.swift
//  PasswordTests
//
//  Created by Admin on 08/04/24.
//

import XCTest

@testable import Password

class ViewControllerTests_Base: XCTestCase {
  
  var vc: ViewController!
  let validPassword = "12345678Aa!"
  let tooShort = "1234Aa!"
  
  override func setUp() {
    super.setUp()
    vc = ViewController()
  }
  
}

class ViewControllerTests_NewPassword_Validation: ViewControllerTests_Base {
  /*
   Here we trigger those criteria blocks by entering text,
   clicking the reset password button, and then checking
   the error label text for the right message.
   */
  
  func testEmptyPassword() throws {
    vc.newPasswordText = ""
    vc.resetPasswordButtonTapped(UIButton())
    
    XCTAssertEqual(vc.newPasswordTextField.errorLabel.text!, "Enter your password")
  }
  
  func testInvalidPassword() throws {
    vc.newPasswordText = "🕹"
    vc.resetPasswordButtonTapped(UIButton())
    
    XCTAssertEqual(vc.newPasswordTextField.errorLabel.text!, "Enter valid special chars (.,@:?!()$\\/#) with no spaces")
  }
  
  func testCriteriaNotMet() throws {
    vc.confirmPasswordText = tooShort
    vc.resetPasswordButtonTapped(UIButton())
    
    XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text!, "Passwords do not match")
  }
  
  func testValidPassword() throws {
    vc.newPasswordText = validPassword
    vc.resetPasswordButtonTapped(UIButton())
    
    XCTAssertTrue(vc.newPasswordTextField.errorLabel.isHidden)
  }
}

class ViewControllerTests_Confirm_Password_Validation: ViewControllerTests_Base {
  func testEmptyPassword() throws {
    vc.confirmPasswordText = ""
    vc.resetPasswordButtonTapped(UIButton())
    
    XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text!, "Enter your password")
  }
  
  func testPasswordsDoNotMatch() throws {
    vc.newPasswordText = validPassword
    vc.confirmPasswordText = tooShort
    vc.resetPasswordButtonTapped(UIButton())
    
    XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text!, "Passwords do not match")
  }
  
  func testPasswordsMatch() throws {
    vc.newPasswordText = validPassword
    vc.confirmPasswordText = validPassword
    vc.resetPasswordButtonTapped(UIButton())
    
    XCTAssertTrue(vc.confirmPasswordTextField.errorLabel.isHidden)
  }
}

class ViewControllerTests_Show_Alert: ViewControllerTests_Base {
  func testShowSuccess() throws {
    vc.newPasswordText = validPassword
    vc.confirmPasswordText = validPassword
    vc.resetPasswordButtonTapped(UIButton())
    
    XCTAssertNotNil(vc.alert)
    XCTAssertEqual(vc.alert!.title, "Success") // Optional
  }
  
  func testShowError() throws {
    vc.newPasswordText = validPassword
    vc.confirmPasswordText = tooShort
    vc.resetPasswordButtonTapped(UIButton())
    
    XCTAssertNil(vc.alert)
  }
}
