//
//  FunctionWTest+Catch.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP
import XCTest
@testable import SwiftCompose

public extension FunctionWTest {
  public func test_functionCatch_shouldWork() {
    /// Setup
    var actualError: Error?
    var actualResult: Int?
    let sInt: SupplierW<Int> = SupplierW({throw FPError("")})

    /// When
    do {
      actualResult = try sInt.catch({_ in 1}).invoke()
    } catch let e {
      actualError = e
    }

    /// Then
    XCTAssertNil(actualError)
    XCTAssertEqual(actualResult, 1)
  }

  public func test_functionCatchWithoutError_shouldWork() {
    /// Setup
    var actualError: Error?
    var actualResult: Int?
    let sInt: SupplierW<Int> = SupplierW({1})

    /// When
    do {
      actualResult = try sInt.catchReturn(100).invoke()
    } catch let e {
      actualError = e
    }

    /// Then
    XCTAssertNil(actualError)
    XCTAssertEqual(actualResult, 1)
  }

  public func test_functionCatchThrows_shouldWork() {
    /// Setup
    var actualError: Error?
    var actualResult: Int?
    let sInt: SupplierW<Int> = SupplierW({throw FPError("")})

    /// When
    do {
      actualResult = try sInt.catch({throw $0}).invoke()
    } catch let e {
      actualError = e
    }

    /// Then
    XCTAssertNotNil(actualError)
    XCTAssertTrue(actualError is FPError)
    XCTAssertNil(actualResult)
  }
}
