//
//  SupplyComposableTest+Multiple.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 16/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP
import XCTest
@testable import SwiftCompose

public extension SupplyComposableTest {
  public func test_multipleComposition_shouldWork() {
    /// Setup
    var actualError: Error?
    var actualResult: Int?
    var publishCount = 0
    let error = "Error"
    let dispatchQueue = DispatchQueue.global(qos: .background)
    let fInt: Supplier<Int> = {throw FPError(error)}
    let publishF: (Error) -> Void = {_ in publishCount += 1}

    let reset: () -> Void = {
      actualError = nil
      actualResult = nil
      publishCount = 0
    }

    /// When & Then 1
    do {
      actualResult = try SupplyComposable<Int>.publishError(publishF)
        .compose(SupplyComposable.retry(retryCount!))
        .compose(SupplyComposable.timeout(10)(dispatchQueue))
        .wrap(fInt)()
    } catch let e {
      actualError = e
    }

    XCTAssertEqual(actualError?.localizedDescription, error)
    XCTAssertNil(actualResult)
    XCTAssertEqual(publishCount, 1)

    /// When & Then 2
    reset()

    do {
      actualResult = try SupplyComposable<Int>.retry(retryCount!)
        .compose(SupplyComposable.publishError(publishF))
        .compose(SupplyComposable.timeout(10)(dispatchQueue))
        .wrap(fInt)()
    } catch let e {
      actualError = e
    }

    XCTAssertEqual(actualError?.localizedDescription, error)
    XCTAssertNil(actualResult)
    XCTAssertEqual(publishCount, retryCount! + 1)

    /// When & Then 3
    reset()

    do {
      actualResult = try SupplyComposable<Int>.retry(retryCount!)
        .compose(SupplyComposable.retry(retryCount!))
        .compose(SupplyComposable.publishError(publishF))
        .compose(SupplyComposable.timeout(2)(dispatchQueue))
        .compose(SupplyComposable.catchReturn(1)) // Nullify all above.
        .wrap(fInt)()
    } catch let e {
      actualError = e
    }

    XCTAssertNil(actualError)
    XCTAssertEqual(actualResult, 1)
    XCTAssertEqual(publishCount, 0)
  }
}
