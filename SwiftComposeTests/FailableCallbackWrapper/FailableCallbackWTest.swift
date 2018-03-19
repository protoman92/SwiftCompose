//
//  FailableCallbackWTest.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 19/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import XCTest
@testable import SwiftCompose

public final class FailableCallbackWTest: XCTestCase {
  public var testCount: Int!

  override public func setUp() {
    super.setUp()
    testCount = 4
  }
}
