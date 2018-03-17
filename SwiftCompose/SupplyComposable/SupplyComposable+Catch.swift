//
//  SupplyComposable+Catch.swift
//  SwiftCompose
//
//  Created by Hai Pham on 15/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

public extension SupplyComposable {

  /// Catch the error and supply a different value.
  ///
  /// - Parameter c: A Error transform function.
  /// - Returns: A Composable instance.
  public static func `catch`(_ c: @escaping (Error) throws -> T) -> SupplyComposable<T> {
    let sf: SupplierF<T> = {(s: @escaping Supplier<T>) -> Supplier<T> in
      return {
        do {
          return try s()
        } catch let e {
          return try c(e)
        }
      }
    }

    return SupplyComposable(sf)
  }

  /// This is similar to catch, but returns a value when an error occurs.
  ///
  /// - Parameter v: A T instance.
  /// - Returns: A Composable instance.
  public static func catchReturn(_ v: T) -> SupplyComposable<T> {
    return `catch`({_ in v})
  }
}
