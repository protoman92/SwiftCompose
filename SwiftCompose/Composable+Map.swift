//
//  Composable+Map.swift
//  SwiftCompose
//
//  Created by Hai Pham on 16/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

public extension Composable {
    
    /// Map the result of a Supplier to another value.
    ///
    /// - Parameter m: A Mapper function.
    /// - Returns: A Composable instance.
    public static func map(_ m: @escaping (T) throws -> T) -> Composable<T> {
        let sf: SupplierF<T> = {(s: @escaping Supplier<T>) in {try m(s())}}
        return Composable(sf)
    }
}
