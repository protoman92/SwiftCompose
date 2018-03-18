//
//  FunctionW+Publish.swift
//  SwiftCompose
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

public extension FunctionW {

  /// Publish the result of a Function.
  ///
  /// - Parameter p: A callback function.
  /// - Returns: A FunctionW instance.
  public func publish(_ p: @escaping (R) throws -> Void) -> FunctionW<T, R> {
    return FunctionW({
      let value = try self.invoke($0)
      try p(value)
      return value
    })
  }

  /// publishError is similar to publish, but it only publishes if an error
  /// is encountered.
  ///
  /// - Parameter p: An error callback function.
  /// - Returns: A FunctionW instance.
  public func publishError(_ p: @escaping (Error) throws -> Void) -> FunctionW<T, R> {
    return FunctionW({
      do {
        return try self.invoke($0)
      } catch let e {
        try p(e)
        throw e
      }
    })
  }
}
