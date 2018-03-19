//
//  FailableCallbackWTest.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 19/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP
import XCTest
@testable import SwiftCompose

public final class FailableCallbackWTest: XCTestCase {
  public var testCount: Int!

  override public func setUp() {
    super.setUp()
    testCount = 10000
  }

  public func test_convertToFailableCallback_shouldWork() {
    /// Setup
    var actualCallCount = 0
    let cInt = CallbackW<Try<Int>>({_ in})

    let composed = cInt.asFailableCallbackWrapper()
      .skipFailures()
      .publish({_ in actualCallCount += 1})
      .filter({$0 % 2 == 0})
      .distinctUntilChanged()

    /// When
    for i in (0..<testCount!) {
      (0..<3).forEach({_ in try! composed.invoke(i)})
    }

    /// Then
    XCTAssertEqual(actualCallCount, testCount! / 2)
  }
}
