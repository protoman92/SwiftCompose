//
//  FunctionWTest+Multiple.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 16/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP
import XCTest
@testable import SwiftCompose

public extension FunctionWTest {
  public func test_multipleComposition_shouldWork() {
    /// Setup
    var actualError: Error?
    var actualResult: Int?
    var publishCount = 0
    let error = "Error"
    let dispatchQueue = DispatchQueue.global(qos: .background)
    let fInt: SupplierW<Int> = SupplierW({throw FPError(error)})
    let publishF: (Error) -> Void = {_ in publishCount += 1}

    let reset: () -> Void = {
      actualError = nil
      actualResult = nil
      publishCount = 0
    }

    /// When & Then 1
    do {
      actualResult = try fInt.retry(retryCount!)
        .publishError(publishF)
        .timeout(10)(dispatchQueue)
        .invoke()
    } catch let e {
      actualError = e
    }

    XCTAssertEqual(actualError?.localizedDescription, error)
    XCTAssertNil(actualResult)
    XCTAssertEqual(publishCount, 1)

    /// When & Then 2
    reset()

    do {
      actualResult = try fInt.publishError(publishF)
        .retry(retryCount!)
        .timeout(10)(dispatchQueue)
        .invoke()
    } catch let e {
      actualError = e
    }

    XCTAssertEqual(actualError?.localizedDescription, error)
    XCTAssertNil(actualResult)
    XCTAssertEqual(publishCount, retryCount! + 1)

    /// When & Then 3
    reset()

    do {
      actualResult = try fInt.catchReturn(1)
        .publishError(publishF)
        .retry(retryCount!)
        .retry(retryCount!)
        .retry(retryCount!)
        .timeout(2)(dispatchQueue)
        .invoke(())
    } catch let e {
      actualError = e
    }

    XCTAssertNil(actualError)
    XCTAssertEqual(actualResult, 1)
    XCTAssertEqual(publishCount, 0)
  }
}

