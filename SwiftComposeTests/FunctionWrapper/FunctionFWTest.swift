//
//  FunctionFWTest.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 27/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP
import XCTest
@testable import SwiftCompose

extension FunctionWTest {
  public func test_composeFunctionFW_shouldWork() {
    /// Setup
    var actualError: Error?
    var actualResult: Int?
    var publishErrorCount = 0
    var publishArgCount = 0
    let error = "Error"
    let errF: Function<Int, Int> = {_ in throw FPError(error)}

    let composed = FunctionFW<Int, Int>.catchReturn(1)
      .compose(FunctionFW.logArgs())
      .compose(FunctionFW.retry(retries!))
      .compose(FunctionFW.logValue())
      .compose(FunctionFW.publishError({_ in publishErrorCount += 1}))
      .compose(FunctionFW.publishArgs({_ in publishArgCount += 1}))

    print(composed)

    /// When
    do {
      actualResult = try composed.wrap(errF).invoke(0)
    } catch let e {
      actualError = e
    }

    /// Then
    XCTAssertEqual(publishErrorCount, retries + 1)
    XCTAssertEqual(publishArgCount, retries + 1)
    XCTAssertNil(actualError)
    XCTAssertEqual(actualResult, 1)
  }
}
