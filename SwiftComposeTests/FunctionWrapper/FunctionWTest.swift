//
//  FunctionWTest.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 17/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP
import XCTest
@testable import SwiftCompose

public final class FunctionWTest: XCTestCase {
  public var expectTimeout: TimeInterval!
  public var retryCount: Int!
  public var testCount: Int!

  override public func setUp() {
    super.setUp()
    expectTimeout = 10
    retryCount = 100000
    testCount = 1000
  }

  public func test_convertToCallbackAndSupplier_shouldWork() {
    /// Setup
    let error = "Error!"

    let f1 = FunctionW<Int, Int>({$0})
      .asFunctionWrapper()
      .map({_ in ()})
      .asCallbackWrapper()
      .mapArg({(a: Void) in throw FPError(error)})
      .asSupplierWrapper()

    /// When
    do {
      _ = try f1.invoke()
      XCTFail("Should not have completed")
    } catch let e {
      XCTAssertEqual(e.localizedDescription, error)
    }
  }
}
