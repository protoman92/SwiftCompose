//
//  FuncComposableTest+Pair.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 17/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import XCTest
@testable import SwiftCompose

public extension FuncComposableTest {
  public func test_composePair_shouldWork() {
    /// Setup
    var lastValue: Int?

    let pairF: (Int?, Int) throws -> Void = {(a, b) in
      lastValue = a
    }

    let paired = FuncComposable.pair(pairF)

    /// When & Then
    for i in (0..<testCount!) {
      try? paired(i)

      if i > 0 {
        XCTAssertEqual(lastValue!, i - 1)
      }
    }
  }
}
