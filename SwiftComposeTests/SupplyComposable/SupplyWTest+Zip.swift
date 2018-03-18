//
//  SupplyWTest+Zip.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 16/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP
import XCTest
@testable import SwiftCompose

public extension SupplyWTest {
  public func test_composeZip_shouldWork() {
    /// Setup
    let error = "Error"
    let zipF: ([Int]) -> Int = {$0.reduce(0, +)}
    let s1: Supplier<Int> = {1}
    let s2: Supplier<Int> = {2}
    let s3: Supplier<Int> = {throw FPError(error)}
    let composed = SupplierW<Int>.zipVarargs(zipF)

    /// When & Then
    do {
      let result = try composed(s1, s2)()
      XCTAssertEqual(result, 3)
    } catch let e {
      XCTFail(e.localizedDescription)
    }

    do {
      _ = try composed(s1, s2, s3)()
      XCTFail("Should not have completed")
    } catch let e {
      XCTAssertEqual(e.localizedDescription, error)
    }
  }
}
