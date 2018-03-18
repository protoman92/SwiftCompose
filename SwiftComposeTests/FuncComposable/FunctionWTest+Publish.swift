//
//  FunctionWTest+Publish.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import XCTest
@testable import SwiftCompose

public extension FunctionWTest {
  public func test_functionPublish_shouldWork() {
    /// Setup
    var published = 0
    var publishedValue = 0
    let value = 1
    let sInt: SupplierW<Int> = SupplierW({value})

    let publishF: (Int) -> Void = {
      published += 1
      publishedValue = $0
    }

    /// When
    let result = try! sInt.publish(publishF).invoke()

    /// Then
    XCTAssertEqual(result, value)
    XCTAssertEqual(publishedValue, value)
    XCTAssertEqual(published, 1)
  }
}
