//
//  CallbackW+Filter.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 19/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import XCTest
@testable import SwiftCompose

public extension CallbackWTest {
  public func test_callbackFilter_shouldWork() {
    /// Setup
    var actualCallCount = 0
    let cInt: CallbackW<Int> = CallbackW({_ in actualCallCount += 1})
    let composed = cInt.filter({$0 % 2 == 0})

    /// When
    for i in (0..<testCount!) {
      try! composed.invoke(i)
    }

    /// Then
    XCTAssertEqual(actualCallCount, testCount! / 2)
  }
}
