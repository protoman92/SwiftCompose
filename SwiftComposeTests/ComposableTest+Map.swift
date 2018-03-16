//
//  ComposableTest+Map.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 16/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import XCTest
@testable import SwiftCompose

public extension ComposableTest {
  public func test_composeMap_shouldWork() {
    /// Setup
    let fInt: Supplier<Int> = {1}

    /// When
    let result = try? Composable.map({$0 * 2}).wrap(fInt)()

    /// Then
    XCTAssertEqual(result, 2)
  }
}
