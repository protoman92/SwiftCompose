//
//  FunctionWTest+Log.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 19/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import XCTest
@testable import SwiftCompose

public extension FunctionWTest {
  public func test_functionLog_shouldWork() {
    /// Setup
    let prefix = "Prefix "

    let fInt = FunctionW<Int, Int>({$0 * 2})
      .map({$0 * 2})
      .logArgs()
      .logArgs({String(describing: $0)})
      .logArgsPrefix(prefix)
      .logArgsPrefix(prefix, {String(describing: $0)})
      .logValue()
      .logValue({String(describing: $0)})
      .logValuePrefix(prefix)
      .logValuePrefix(prefix, {String(describing: $0)})

    /// When & Then
    for i in (0..<testCount!) {
      _ = try? fInt.invoke(i)
    }
  }
}
