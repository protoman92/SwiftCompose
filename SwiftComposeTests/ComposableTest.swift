//
//  ComposableTest.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 14/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP
import XCTest
@testable import SwiftCompose

public final class ComposableTest: XCTestCase {
  public var expectTimeout: TimeInterval!
  public var retryCount: Int!

  override public func setUp() {
    super.setUp()
    expectTimeout = 10
    retryCount = 100000
  }
}
