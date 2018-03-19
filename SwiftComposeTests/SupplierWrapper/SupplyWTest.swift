//
//  SupplyWTest.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 14/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP
import XCTest
@testable import SwiftCompose

public final class SupplyWTest: XCTestCase {
  public var expectTimeout: TimeInterval!
  public var retryCount: Int!

  override public func setUp() {
    super.setUp()
    expectTimeout = 10
    retryCount = 100000
  }

  public func test_convertToFunctionWrapper_shouldWork() {
    /// Setup
    let error = "Error"

    let sInt = SupplierW<Int>({_ in throw FPError(error)})
      .asSupplierWrapper()
      .asFunctionWrapper()

    /// When & Then
    do {
      _ = try sInt.invoke(())
      XCTFail("Should not have completed")
    } catch let e {
      XCTAssertEqual(e.localizedDescription, error)
    }
  }
}
