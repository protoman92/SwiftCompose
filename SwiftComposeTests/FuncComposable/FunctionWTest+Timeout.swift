//
//  FunctionWTest+Timeout.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP
import XCTest
@testable import SwiftCompose

public extension FunctionWTest {
  public func test_composeTimeout_shouldWork() {
    /// Setup
    var actualError1: Error?
    var actualError2: Error?
    var actualResult1: Int?
    var actualResult2: Int?
    let timeout: TimeInterval = 1
    let dispatchQueue = DispatchQueue.global(qos: .background)

    let sInt1: SupplierW<Int> = SupplierW({
      Thread.sleep(forTimeInterval: timeout * 2)
      return 1
    })

    let sInt2: SupplierW<Int> = SupplierW({
      Thread.sleep(forTimeInterval: timeout / 2)
      return 2
    })

    /// When
    do {
      actualResult1 = try sInt1.timeout(timeout)(dispatchQueue).invoke()
    } catch let e {
      actualError1 = e
    }

    do {
      actualResult2 = try sInt2.timeout(timeout)(dispatchQueue).invoke()
    } catch let e {
      actualError2 = e
    }

    /// Then
    XCTAssertTrue(actualError1 is FPError)
    XCTAssertNil(actualResult1)
    XCTAssertNil(actualError2)
    XCTAssertEqual(actualResult2, 2)
  }
}
