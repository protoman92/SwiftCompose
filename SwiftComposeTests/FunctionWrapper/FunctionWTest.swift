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
  public var retries: Int!
  public var retryDelay: TimeInterval!
  public var testCount: Int!

  override public func setUp() {
    super.setUp()
    expectTimeout = 10
    retries = 100000
    retryDelay = 0.1
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
