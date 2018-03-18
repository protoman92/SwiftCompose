//
//  FunctionWTest+Async.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 16/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP
import XCTest
@testable import SwiftCompose

public extension FunctionWTest {
  public func test_composeInDifferentDispatchQueue_shouldWork() {
    /// Setup
    var actualError: Error?
    var actualResult: Int?
    let error = "Error"
    let timeout: TimeInterval = 1

    let sInt: SupplierW<Int> = SupplierW({
      Thread.sleep(forTimeInterval: timeout * 2)
      throw FPError(error)
    })

    let callingDq = DispatchQueue.global(qos: .background)
    let performDq = DispatchQueue.global(qos: .background)
    let composed = sInt.retry(retryCount!).timeout(timeout)(performDq)
    let expect = expectation(description: "Should have completed")

    /// When
    let start = Date()

    callingDq.async {
      do {
        actualResult = try composed.invoke()
      } catch let e {
        actualError = e
      }

      expect.fulfill()
    }

    let difference = Date().timeIntervalSince(start)
    waitForExpectations(timeout: expectTimeout!, handler: nil)

    /// Then
    XCTAssertTrue(actualError is FPError)
    XCTAssertNil(actualResult)
    XCTAssertLessThan(difference, 0.1)
  }
}

