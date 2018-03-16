//
//  ComposableTest+Retry.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 16/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP
import XCTest
@testable import SwiftCompose

public extension ComposableTest {
  public func test_composeRetry_shouldWork() {
    /// Setup
    var actualError: Error?
    var actualTryCount = 0
    let error = "Error!"

    let fInt: Supplier<Int> = {
      actualTryCount += 1
      throw FPError(error)
    }

    let retryF = Composable<Int>.retry(retryCount!)

    /// When
    do {
      _ = try retryF.wrap(fInt)()
    } catch let e {
      actualError = e
    }

    /// Then
    XCTAssertEqual(actualTryCount, retryCount! + 1)
    XCTAssertEqual(actualError?.localizedDescription, error)
  }

  public func test_composeRetryWithDelay_shouldWork() {
    /// Setup
    retryCount = 15
    var actualError: Error?
    var actualTryCount = 0
    let duration: TimeInterval = 0.2
    let error = "Error!"

    let fInt: Supplier<Int> = {
      actualTryCount += 1
      throw FPError(error)
    }

    let retryF = Composable<Int>.retryWithDelay(retryCount!)(duration)

    /// When
    let start = Date()

    do {
      _ = try retryF.wrap(fInt)()
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
