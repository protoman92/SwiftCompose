//
//  CallbackWTest+Distinct.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import XCTest
@testable import SwiftCompose

public extension CallbackWTest {
  public func test_composeDistinct_shouldWork() {
    /// Setup
    var callCount = 0
    let callbackF: CallbackW<Int> = CallbackW({_ in callCount += 1})
    let distinctF = callbackF.distinctUntilChanged()

    /// When
    for i in (0..<testCount!) {
      (0..<100).forEach({_ in try! distinctF.invoke(i)})
    }

    /// Then
    XCTAssertEqual(callCount, testCount!)
  }
}
