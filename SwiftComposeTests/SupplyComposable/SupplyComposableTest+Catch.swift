//
//  SupplyComposableTest+Catch.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 16/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP
import XCTest
@testable import SwiftCompose

public extension SupplyComposableTest {
  public func test_composeCatch_shouldWork() {
    /// Setup
    var actualError: Error?
    var actualResult: Int?
    let fInt: Supplier<Int> = {throw FPError("")}

    /// When
    do {
      actualResult = try SupplyComposable.catch({_ in 1}).wrap(fInt)()
    } catch let e {
      actualError = e
    }

    /// Then
    XCTAssertNil(actualError)
    XCTAssertEqual(actualResult, 1)
  }

  public func test_composableCatchWithoutError_shouldWork() {
    /// Setup
    var actualError: Error?
    var actualResult: Int?
    let fInt: Supplier<Int> = {1}

    /// When
    do {
      actualResult = try SupplyComposable.catchReturn(100).wrap(fInt)()
    } catch let e {
      actualError = e
    }

    /// Then
    XCTAssertNil(actualError)
    XCTAssertEqual(actualResult, 1)
  }

  public func test_composeCatchThrows_shouldWork() {
    /// Setup
    var actualError: Error?
    var actualResult: Int?
    let fInt: Supplier<Int> = {throw FPError("")}

    /// When
    do {
      actualResult = try SupplyComposable.catch({throw $0}).wrap(fInt)()
    } catch let e {
      actualError = e
    }

    /// Then
    XCTAssertNotNil(actualError)
    XCTAssertTrue(actualError is FPError)
    XCTAssertNil(actualResult)
  }
}
