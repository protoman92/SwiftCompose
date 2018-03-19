//
//  FunctionW+Catch.swift
//  SwiftCompose
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

public extension FunctionWrapperType {

  /// Catch the error and return a different value.
  ///
  /// - Parameter c: A Error transform function.
  /// - Returns: A Self instance.
  public func `catch`(_ c: @escaping (Error) throws -> R) -> Self {
    let function: Function<T, R> = ({
      do {
        return try self.invoke($0)
      } catch let e {
        return try c(e)
      }
    })

    #if DEBUG
      let description = appendDescription("Added catch")
      return Self(function, description)
    #else
      return Self(function)
    #endif
  }

  /// This is similar to catch, but returns a value when an error occurs.
  ///
  /// - Parameter v: A R instance.
  /// - Returns: A Self instance.
  public func catchReturn(_ v: R) -> Self {
    return `catch`({_ in v})
  }
}
