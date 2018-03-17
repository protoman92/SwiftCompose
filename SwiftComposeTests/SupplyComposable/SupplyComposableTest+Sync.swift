//
//  SupplyComposableTest+Sync.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 16/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP
import XCTest
@testable import SwiftCompose

public extension SupplyComposableTest {
  public func test_composeAsyncToSync_shouldWork() {
    /// Setup
    var actualResult: Int?
    let sleepTime: TimeInterval = 1

    let asyncOp: AsyncOperation<Int> = {(callback: @escaping AsyncCallback<Int>) in
      DispatchQueue.global(qos: .background).async {
        Thread.sleep(forTimeInterval: sleepTime)
        callback(Try.success(3))
      }
    }

    let composed = SupplyComposable.sync(asyncOp)
    let expect = expectation(description: "Should have completed")

    /// When
    DispatchQueue.global(qos: .background).async {
      actualResult = try? composed()
      expect.fulfill()
    }

    waitForExpectations(timeout: expectTimeout!, handler: nil)

    /// Then
    XCTAssertEqual(actualResult, 3)
  }

  public func test_composeAsyncWithOtherComposable_shouldWork() {
    /// Setup
    struct CustomError: LocalizedError {
      private let message: String
      private let object: Any

      public var errorDescription: String? {
        return message
      }

      public init(_ message: String, _ object: Any) {
        self.message = message
        self.object = object
      }
    }

    var actualResult: String?
    var actualError: Error?
    var publishCount = 0
    let error = "Error"

    let asyncOp: AsyncOperation<String> = {(callback: @escaping AsyncCallback<String>) in
      DispatchQueue.global(qos: .utility).async {
        let cError = CustomError(error, NSArray())
        callback(Try.failure(cError))
      }
    }

    /// When
    do {
      actualResult = try SupplyComposable<String>.retry(retryCount!)
        .compose(SupplyComposable.publishError({_ in publishCount += 1}))
        .wrap(SupplyComposable.sync(asyncOp))()
    } catch let e {
      actualError = e
    }

    /// Then
    XCTAssertNil(actualResult)
    XCTAssertEqual(actualError?.localizedDescription, error)
    XCTAssertEqual(publishCount, retryCount! + 1)
  }
}
