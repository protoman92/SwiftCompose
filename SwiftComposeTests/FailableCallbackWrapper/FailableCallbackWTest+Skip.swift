//
//  FailableCallbackWTest+Skip.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 19/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP
import XCTest
@testable import SwiftCompose

public extension FailableCallbackWTest {
  public func test_skipNilsAndFailures_shouldWork() {
    /// Setup
    var actualCallCount1 = 0
    var actualCallCount2 = 0
    let fcInt1 = FailableCallbackW<Int?>({_ in actualCallCount1 += 1}).skipNils()
    let fcInt2 = FailableCallbackW<Try<Int>>({_ in actualCallCount2 += 1}).skipFailures()

    /// When
    for i in (0..<testCount!) {
      try? fcInt1.invoke(i)
      try? fcInt2.invoke(i)
    }

    /// Then
    XCTAssertEqual(actualCallCount1, testCount!)
    XCTAssertEqual(actualCallCount2, testCount!)
  }
}
