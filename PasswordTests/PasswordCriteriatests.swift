//
//  PasswordCriteriatests.swift
//  PasswordTests
//
//  Created by Admin on 07/04/24.
//

import XCTest

@testable import Password

class PasswordLengthCriteriaTests: XCTestCase {
  
  // Boundary conditions 8-32
  
  func testShort() throws {
    XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("1234567"))
  }
  
  func testLong() throws {  // 33
    XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("123456789012345678901234567890123"))
  }
  
  func testValidShort() throws { // 8
    XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678"))
  }
  
  func testValidLong() throws { // 32
    XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678901234567890123456789012"))
  }
}

class PasswordOtherCriteriaTests: XCTestCase {
  func testSpaceMet() throws {
    XCTAssertTrue(PasswordCriteria.noSpaceCriteriaMet("abc"))
  }
  
  func testSpaceNotMet() throws {
    XCTAssertFalse(PasswordCriteria.noSpaceCriteriaMet("a bc"))
  }
  
  func testLengthAndNoSpaceMet() throws {
    XCTAssertTrue(PasswordCriteria.lengthAndNoSpaceCriteriaMet("12345678"))
  }
  
  func testLengthAndNoSpaceNotMet() throws {
    XCTAssertFalse(PasswordCriteria.lengthAndNoSpaceCriteriaMet("1234567 8"))
  }
  
  func testUpperCaseMet() throws {
    XCTAssertTrue(PasswordCriteria.uppercaseCriteriaMet("A"))
  }
  
  func testUpperCaseNotMet() throws {
    XCTAssertFalse(PasswordCriteria.uppercaseCriteriaMet("a"))
  }
  
  func testLowerCaseMet() throws {
    XCTAssertTrue(PasswordCriteria.lowercaseCriteriaMet("a"))
  }
  
  func testLowerCaseNotMet() throws {
    XCTAssertFalse(PasswordCriteria.lowercaseCriteriaMet("A"))
  }
  
  func testDigitMet() throws {
    XCTAssertTrue(PasswordCriteria.digitMet("1"))
  }
  
  func testDigitNotMet() throws {
    XCTAssertFalse(PasswordCriteria.digitMet("a"))
  }
  
  func testSpecicalCharMet() throws {
    XCTAssertTrue(PasswordCriteria.specialCharacterMet("@"))
  }
  
  func testSpecicalCharNotMet() throws {
    XCTAssertFalse(PasswordCriteria.specialCharacterMet("a"))
  }
}
