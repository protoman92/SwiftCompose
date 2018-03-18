//
//  CallbackW.swift
//  SwiftCompose
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

/// Wrapper for a callback function.
public typealias CallbackW<T> = FunctionW<T, Void>

/// Extensions for CallbackW.
public extension FunctionW where R == Void {

  /// Do not invoke the callback while the arguments have not changed.
  ///
  /// - Parameter c: Comparison function. Return true if different.
  /// - Returns: A CallbackW instance.
  public func distinctUntilChanged(_ c: @escaping (T, T) throws -> Bool) -> CallbackW<T> {
    let pairF: PairFunction<T, Void> = {
      if $0 == nil {
        try self.invoke($1)
      } else if let prev = $0, try c(prev, $1) {
        try self.invoke($1)
      }
    }

    return FuncComposable<T, Void>.pair(pairF)
  }
}

public extension FunctionW where T: Equatable, R == Void {

  /// Convenience function that makes use of equatability.
  ///
  /// - Returns: A CallbackW instance.
  public func distinctUntilChanged() -> CallbackW<T> {
    return distinctUntilChanged({$0 != $1})
  }
}
