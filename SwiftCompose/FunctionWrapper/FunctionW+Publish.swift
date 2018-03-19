//
//  FunctionW+Publish.swift
//  SwiftCompose
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

public extension FunctionWrapperType {

  /// Publish the result of a Function.
  ///
  /// - Parameter p: A callback function.
  /// - Returns: A Self instance.
  public func publish(_ p: @escaping Callback<R>) -> Self {
    let function: Function<T, R> = {
      let value = try self.invoke($0)
      try p(value)
      return value
    }

    #if DEBUG
      let description = appendDescription("Added publish")
      return Self(function, description)
    #else
      return Self(function)
    #endif
  }

  /// Publish the input argument.
  ///
  /// - Parameter p: A callback function.
  /// - Returns: A Self instance.
  public func publishArgs(_ p: @escaping Callback<T>) -> Self {
    let function: Function<T, R> = {
      try p($0)
      return try self.invoke($0)
    }

    #if DEBUG
      let description = appendDescription("Added publish arg")
      return Self(function, description)
    #else
      return Self(function)
    #endif
  }

  /// publishError is similar to publish, but it only publishes if an error
  /// is encountered.
  ///
  /// - Parameter p: An error callback function.
  /// - Returns: A Self instance.
  public func publishError(_ p: @escaping Callback<Error>) -> Self {
    let function: Function<T, R> = ({
      do {
        return try self.invoke($0)
      } catch let e {
        try p(e)
        throw e
      }
    })

    #if DEBUG
      let description = appendDescription("Added publish error")
      return Self(function, description)
    #else
      return Self(function)
    #endif
  }
}
