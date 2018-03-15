//
//  Composable+Zip.swift
//  SwiftCompose
//
//  Created by Hai Pham on 16/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

public extension Composable {
    
    /// Zip the results of a Sequence of Suppliers with the value returned by
    /// the invoked Supplier.
    ///
    /// - Parameter z: Zipper function.
    /// - Returns: A custom higher-order function.
    public static func zip(_ z: @escaping ([T]) throws -> T) -> ([Supplier<T>]) -> Composable<T> {
        return {(ss: [Supplier<T>]) in
            let sf: SupplierF<T> = {(s: @escaping Supplier<T>) in
                var newSf = ss
                newSf.append(s)
                return {try z(newSf.map({try $0()}))}
            }
            
            return Composable(sf)
        }
    }
    
    /// This is similar to zip, but the arguments in the curried function are
    /// variadic.
    ///
    /// - Parameter z: Zipper function.
    /// - Returns: A custom higher-order function.
    public static func zipVarargs(_ z: @escaping ([T]) throws -> T) -> (Supplier<T>...) -> Composable<T> {
        return {(ss: Supplier<T>...) in zip(z)(ss.map({$0}))}
    }
}
