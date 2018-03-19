//
//  CallbackWTest.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP
import XCTest
@testable import SwiftCompose

public final class CallbackWTest: XCTestCase {
  public var testCount: Int!

  override public func setUp() {
    super.setUp()
    testCount = 1000
  }

  public func test_convertToFunctionWrapper_shouldWork() {
    /// Setup
    let error = "Error"

    let sInt = CallbackW<Int>({_ in throw FPError(error)})
      .asCallbackWrapper()
      .asFunctionWrapper()

    /// When & Then
    do {
      _ = try sInt.invoke(0)
      XCTFail("Should not have completed")
    } catch let e {
      XCTAssertEqual(e.localizedDescription, error)
    }
  }
}
