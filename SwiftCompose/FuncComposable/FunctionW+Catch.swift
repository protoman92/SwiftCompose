//
//  FunctionW+Catch.swift
//  SwiftCompose
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

public extension FunctionW {

  /// Catch the error and return a different value.
  ///
  /// - Parameter c: A Error transform function.
  /// - Returns: A FunctionW instance.
  public func `catch`(_ c: @escaping (Error) throws -> R) -> FunctionW<T, R> {
    return FunctionW({
      do {
        return try self.invoke($0)
      } catch let e {
        return try c(e)
      }
    })
  }

  /// This is similar to catch, but returns a value when an error occurs.
  ///
  /// - Parameter v: A R instance.
  /// - Returns: A FunctionW instance.
  public func catchReturn(_ v: R) -> FunctionW<T, R> {
    return `catch`({_ in v})
  }
}
