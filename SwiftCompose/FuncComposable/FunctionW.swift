//
//  FunctionW.swift
//  SwiftCompose
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

/// Wrapper for Function.
public struct FunctionW<T, R> {
  fileprivate let f: Function<T, R>

  public init(_ f: @escaping Function<T, R>) {
    self.f = f
  }

  public func invoke(_ value: T) throws -> R {
    return try f(value)
  }

  /// Reverse-map the input argument from a different type.
  ///
  /// - Parameter m: Mapper function.
  /// - Returns: A FunctionW instance.
  public func mapArg<T1>(_ m: @escaping (T1) throws -> T) -> FunctionW<T1, R> {
    let f1: Function<T1, R> = ({try self.invoke(m($0))})
    return FunctionW<T1, R>(f1)
  }

  /// Map the return value to another type.
  ///
  /// - Parameter m: Mapper function.
  /// - Returns: A FunctionW instance.
  public func map<R1>(_ m: @escaping (R) throws -> R1) -> FunctionW<T, R1> {
    let f1: Function<T, R1> = ({try m(self.invoke($0))})
    return FunctionW<T, R1>(f1)
  }
}
