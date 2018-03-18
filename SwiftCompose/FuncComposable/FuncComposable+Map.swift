//
//  FuncComposable+Map.swift
//  SwiftCompose
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

public extension FuncComposable {

  /// Map the argument of a Function to another type.
  ///
  /// - Parameter m: Mapper function.
  /// - Returns: A FuncMapArgComposable instance.
  public static func mapArg<T1>(_ m: @escaping (T) throws -> T1) -> FuncMapArgComposable<T, T1, R> {
    let mff: (@escaping Function<T1, R>) -> Function<T, R> =  {
      (f1: @escaping Function<T1, R>) in return {try f1(m($0))}
    }

    return FuncMapArgComposable(mff)
  }
}

/// Convenience wrapper data structure.
public struct FuncMapArgComposable<T, T1, R> {
  fileprivate let mff: MapArgFunctionF<T, T1, R>

  public init(_ mff: @escaping (@escaping Function<T1, R>) -> Function<T, R>) {
    self.mff = mff
  }

  public func wrap(_ f: @escaping Function<T1, R>) -> Function<T, R> {
    return mff(f)
  }
}
