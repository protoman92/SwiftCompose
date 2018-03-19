//
//  FunctionWTest+Retry.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP
import XCTest
@testable import SwiftCompose

public extension FunctionWTest {
  public func test_functionRetry_shouldWork() {
    /// Setup
    var actualError: Error?
    var actualTryCount = 0
    let error = "Error!"

    let sInt: SupplierW<Int> = SupplierW({
      actualTryCount += 1
      throw FPError(error)
    })

    /// When
    do {
      _ = try sInt.retry(retryCount!).invoke()
    } catch let e {
      actualError = e
    }

    /// Then
    XCTAssertEqual(actualTryCount, retryCount! + 1)
    XCTAssertEqual(actualError?.localizedDescription, error)
  }

  public func test_functionRetryWithDelay_shouldWork() {
    /// Setup
    retryCount = 15
    var actualError: Error?
    var actualTryCount = 0
    let duration: TimeInterval = 0.2
    let error = "Error!"

    let sInt: SupplierW<Int> = SupplierW({
      actualTryCount += 1
      throw FPError(error)
    })

    /// When
    let start = Date()

    do {
      _ = try sInt.retryWithDelay(retryCount!)(duration).invoke()
    } catch let e {
      actualError = e
    }

    let difference = Date().timeIntervalSince(start)

    /// Then
    XCTAssertEqual(actualTryCount, retryCount! + 1)
    XCTAssertLessThan((difference / Double(retryCount!) - duration) / duration, 0.1)
    XCTAssertEqual(actualError?.localizedDescription, error)
  }
}
