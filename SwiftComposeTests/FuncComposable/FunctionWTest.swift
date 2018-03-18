//
//  FunctionWTest.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 17/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import XCTest
@testable import SwiftCompose

public final class FunctionWTest: XCTestCase {
  public var expectTimeout: TimeInterval!
  public var retryCount: Int!
  public var testCount: Int!

  override public func setUp() {
    super.setUp()
    expectTimeout = 10
    retryCount = 100000
    testCount = 1000
  }
}
