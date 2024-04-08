//
//  PasswordStatusViewTests.swift
//  PasswordTests
//
//  Created by Admin on 08/04/24.
//
import XCTest

@testable import Password

class PasswordStatusViewTests_Base: XCTestCase {
  
  var statusView: PassworStatusView!
  let validPassword = "12345678Aa!"
  let tooShort = "123Aa!"
  
  override func setUp() {
    super.setUp()
    statusView = PassworStatusView()
  }
  
}

class PasswordStatusViewTests_ShowCheckmarkOrReset_When_Validation_Is_Inline: PasswordStatusViewTests_Base {
  
  override func setUp() {
    super.setUp()
    statusView.shouldResetCriteria = true // inline
  }
  
  /*
       if shouldResetCriteria {
           // Inline validation (✅ or ⚪️)
       } else {
           ...
       }
  */
 
  func testValidPassword() throws {
    statusView.updateDisplay(validPassword)
    XCTAssertTrue(statusView.lengthCriteriaView.criteriaMet == .checkMark)
    XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage) // ✅
  }
  
  
  func testTooShort() throws {
    statusView.updateDisplay(tooShort)
    XCTAssertFalse(statusView.lengthCriteriaView.criteriaMet == .checkMark)
    XCTAssertTrue(statusView.lengthCriteriaView.isResetImage)  // ⚪️
  }
  
}

class PasswordStatusViewTests_ShowCheckmarkOrRedX_When_Validation_Is_Loss_Of_Focus: PasswordStatusViewTests_Base {
 
  override func setUp() {
    super.setUp()
    statusView.shouldResetCriteria = false // loos of focus
  }
  
  /*
   if shouldResetCriteria {
       ...
   } else {
       // Focus lost (✅ or ❌)
   }
   */

  func testValidPassword() throws {
    statusView.updateDisplay(validPassword)
    XCTAssertTrue(statusView.lengthCriteriaView.criteriaMet == .checkMark)
    XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage) // ✅
  }
  
  func testTooShort() throws {
    statusView.updateDisplay(tooShort)
    XCTAssertFalse(statusView.lengthCriteriaView.criteriaMet == .checkMark)
    XCTAssertTrue(statusView.lengthCriteriaView.isXmarkImage) // ❌
  }
}

class PasswordStatusViewTests_Validate_Two_Of_Four: PasswordStatusViewTests_Base {
  
  let twoOfFour = "12345678a"
  let threeOfFour = "12345678A!"
  
  func testTwoOfFour() throws {
    XCTAssertFalse(statusView.validate(twoOfFour))
  }
  
  func testThreeOfFour() throws {
    XCTAssertTrue(statusView.validate(threeOfFour))
  }
  
  func testFourOfFour() throws {
    XCTAssertTrue(statusView.validate(validPassword))
  }
  
}
