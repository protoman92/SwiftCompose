//
//  SupplyComposable+Async.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 16/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP
import XCTest
@testable import SwiftCompose

public extension SupplyComposableTest {
  public func test_invokeAsync_shouldWork() {
    /// Setup
    var errorCount = 0
    var publishCount = 0
    let error = "Error"
    let fInt: Supplier<Int> = {throw FPError(error)}
    let dispatchQueue = DispatchQueue.global(qos: .background)
    let expect = expectation(description: "Should have completed")

    let composed1 = SupplyComposable<Int>.retry(retryCount!)
      .compose(SupplyComposable.publishError({_ in publishCount += 1}))
      .wrapAsync({
        do {
          _ = try $0.getOrThrow()
        } catch {
          errorCount += 1
          expect.fulfill()
        }
      })

    /// When
    composed1(dispatchQueue)(fInt)()
    waitForExpectations(timeout: expectTimeout, handler: nil)

    /// Then
    XCTAssertEqual(errorCount, 1)
    XCTAssertEqual(publishCount, retryCount! + 1)
  }

  public func test_composeInDifferentDispatchQueue_shouldWork() {
    /// Setup
    var actualError: Error?
    var actualResult: Int?
    let error = "Error"
    let timeout: TimeInterval = 1

    let fInt: Supplier<Int> = {
      Thread.sleep(forTimeInterval: timeout * 2)
      throw FPError(error)
    }

    let callingDq = DispatchQueue.global(qos: .background)
    let performDq = DispatchQueue.global(qos: .background)

    let composed = SupplyComposable<Int>.timeout(timeout)(performDq)
      .compose(SupplyComposable.retry(retryCount!))
      .compose(SupplyComposable.noop())

    let expect = expectation(description: "Should have completed")

    /// When
    let start = Date()

    callingDq.async {
      do {
        actualResult = try composed.wrap(fInt).invoke()
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
