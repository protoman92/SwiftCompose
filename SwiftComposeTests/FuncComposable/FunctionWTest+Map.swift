//
//  FuncComposableTest+Map.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP
import XCTest
@testable import SwiftCompose

public extension FunctionWTest {
  public func test_functionWMapArg_shouldWork() {
    /// Setup
    let f = FunctionW<String, Int>({Int($0)!})
    let f1 = f.mapArg({(a: Int) in String(describing: a)})
    let f2 = f1.map({String(describing: $0)})

    /// When & Then
    XCTAssertEqual(try! f1.invoke(1), 1)
    XCTAssertEqual(try! f2.invoke(1), "1")
  }
}
