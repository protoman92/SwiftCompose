//
//  FunctionWTest+Misc.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 19/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP
import XCTest
@testable import SwiftCompose

public extension FunctionWTest {
  public func test_convertToCallbackAndSupplier_shouldWork() {
    /// Setup
    let error = "Error!"

    let f1 = FunctionW<Int, Int>({$0})
      .map({_ in ()})
      .asCallbackWrapper()
      .mapArg({(a: Void) in throw FPError(error)})
      .asSupplierWrapper()

    /// When
    do {
      try f1.invoke()
    } catch let e {
      XCTAssertEqual(e.localizedDescription, error)
    }
  }
}
