//
//  ComposableTest+Publish.swift
//  SwiftComposeTests
//
//  Created by Hai Pham on 16/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import XCTest
@testable import SwiftCompose

public extension ComposableTest {
    public func test_composePublish_shouldWork() {
        /// Setup
        var published = 0
        var publishedValue = 0
        let value = 1
        let fInt: Supplier<Int> = {value}
        
        let publishF: (Int) -> Void = {
            published += 1
            publishedValue = $0
        }
        
        let publishC = Composable.publish(publishF)
        
        /// When
        let result = try! publishC.invoke(fInt)()
        
        /// Then
        XCTAssertEqual(result, value)
        XCTAssertEqual(publishedValue, value)
        XCTAssertEqual(published, 1)
    }
}
