//
//  FunctionW+Map.swift
//  SwiftCompose
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

/// Weirdly enough, this does not compile if we return FunctionWrapperType,
/// although it's valid syntax.
public extension FunctionWrapperType {

  /// Reverse-map the input argument from a different type.
  ///
  /// - Parameter m: Mapper function.
  /// - Returns: A Self instance.
  public func mapArg<T1>(_ m: @escaping (T1) throws -> T) -> FunctionW<T1, R> {
    let f1: Function<T1, R> = ({try self.invoke(m($0))})
    return FunctionW(f1)
  }

  /// Map the return value to another type.
  ///
  /// - Parameter m: Mapper function.
  /// - Returns: A Self instance.
  public func map<R1>(_ m: @escaping (R) throws -> R1) -> FunctionW<T, R1> {
    let f1: Function<T, R1> = ({try m(self.invoke($0))})
    return FunctionW(f1)
  }
}
