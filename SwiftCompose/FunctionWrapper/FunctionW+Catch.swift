//
//  FunctionW+Catch.swift
//  SwiftCompose
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

#if DEBUG
private func catchDesc() -> String {
  return "Added catch"
}
#endif

public extension FunctionFWrapperType {

  /// Catch the error and return a different value.
  ///
  /// - Parameter c: A Error transform function.
  /// - Returns: A Self instance.
  public static func `catch`(_ c: @escaping (Error) throws -> R) -> Self {
    let ff: FunctionF<T, R> = ({(f: @escaping Function<T, R>) in
      return {
        do {
          return try f($0)
        } catch let e {
          return try c(e)
        }
      }
    })

    #if DEBUG
    return Self(ff, catchDesc())
    #else
    return Self(ff)
    #endif
  }

  /// This is similar to catch, but returns a value when an error occurs.
  ///
  /// - Parameter v: A R instance.
  /// - Returns: A Self instance.
  public static func catchReturn(_ v: R) -> Self {
    return `catch`({_ in v})
  }
}

public extension FunctionWrapperType {

  /// Catch the error and return a different value.
  ///
  /// - Parameter c: A Error transform function.
  /// - Returns: A Self instance.
  public func `catch`(_ c: @escaping (Error) throws -> R) -> Self {
    let f = FunctionFW<T, R>.catch(c).wrap(self.f).f

    #if DEBUG
    let description = appendDescription("Added catch")
    return Self(f, description)
    #else
    return Self(f)
    #endif
  }

  /// This is similar to catch, but returns a value when an error occurs.
  ///
  /// - Parameter v: A R instance.
  /// - Returns: A Self instance.
  public func catchReturn(_ v: R) -> Self {
    let f = FunctionFW<T, R>.catchReturn(v).wrap(self.f).f

    #if DEBUG
    let description = appendDescription("Added catchReturn with \(v)")
    return Self(f, description)
    #else
    return Self(f)
    #endif
  }
}
