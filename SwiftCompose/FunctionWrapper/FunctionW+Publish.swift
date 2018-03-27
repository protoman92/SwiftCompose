//
//  FunctionW+Publish.swift
//  SwiftCompose
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

#if DEBUG
private func publishDesc() -> String {
  return "Added publish"
}

private func publishArgDesc() -> String {
  return "Added publish arg"
}

private func publishErrorDesc() -> String {
  return "Added publish error"
}
#endif

public extension FunctionFWrapperType {

  /// Publish the result of a Function.
  ///
  /// - Parameter p: A Callback instance.
  /// - Returns: A Self instance.
  public static func publish(_ p: @escaping Callback<R>) -> Self {
    let ff: FunctionF<T, R> = {(f: @escaping Function<T, R>) in
      return { let value = try f($0); try p(value); return value }
    }

    #if DEBUG
    return Self(ff, publishDesc())
    #else
    return Self(ff)
    #endif
  }

  public static func publishArgs(_ p: @escaping Callback<T>) -> Self {
    let ff: FunctionF<T, R> = {(f: @escaping Function<T, R>) in
      return { try p($0); return try f($0) }
    }

    #if DEBUG
    return Self(ff, publishArgDesc())
    #else
    return Self(ff)
    #endif
  }

  /// Publish the error the a Function may throw.
  ///
  /// - Parameter p: A Callback instance.
  /// - Returns: A Self instance.
  public static func publishError(_ p: @escaping Callback<Error>) -> Self {
    let ff: FunctionF<T, R> = {(f: @escaping Function<T, R>) in
      return {
        do {
          return try f($0)
        } catch let e {
          try p(e)
          throw e
        }
      }
    }

    #if DEBUG
    return Self(ff, publishErrorDesc())
    #else
    return Self(ff)
    #endif
  }
}

public extension FunctionWrapperType {

  /// Publish the result of a Function.
  ///
  /// - Parameter p: A Callback instance.
  /// - Returns: A Self instance.
  public func publish(_ p: @escaping Callback<R>) -> Self {
    let function: Function<T, R> = {
      try FunctionFW<T, R>.publish(p).wrap(self.f).invoke($0)
    }

    #if DEBUG
    let description = appendDescription(publishDesc())
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
    let f = FunctionFW<T, R>.publishArgs(p).wrap(self.f).f

    #if DEBUG
    let description = appendDescription(publishArgDesc())
    return Self(f, description)
    #else
    return Self(f)
    #endif
  }

  /// publishError is similar to publish, but it only publishes if an error
  /// is encountered.
  ///
  /// - Parameter p: An Callback instance.
  /// - Returns: A Self instance.
  public func publishError(_ p: @escaping Callback<Error>) -> Self {
    let f = FunctionFW<T, R>.publishError(p).wrap(self.f).f

    #if DEBUG
    let description = appendDescription(publishErrorDesc())
    return Self(f, description)
    #else
    return Self(f)
    #endif
  }
}
