//
//  CallbackW+Distinct.swift
//  SwiftCompose
//
//  Created by Hai Pham on 19/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP

public extension CallbackW {

  /// Do not invoke the callback while the arguments have not changed.
  ///
  /// - Parameter c: Comparison function. Return true if different.
  /// - Returns: A CallbackW instance.
  public func distinctUntilChanged(_ c: @escaping (T, T) throws -> Bool) -> CallbackW<T> {
    let pairF: PairFunction<T, Void> = {
      if $0 == nil {
        _ = try self.invoke($1)
      } else if let prev = $0, try c(prev, $1) {
        _ = try self.invoke($1)
      }
    }

    return CallbackW<T>.pair(pairF)
  }
}

public extension CallbackW where T: Equatable {

  /// Convenience function that makes use of equatability.
  ///
  /// - Returns: A CallbackW instance.
  public func distinctUntilChanged() -> CallbackW<T> {
    return distinctUntilChanged({$0 != $1})
  }
}

public extension CallbackW where T: TryConvertibleType, T.Val: Equatable {

  /// Convenience function that makes use of equatability.
  ///
  /// - Returns: A CallbackW instance.
  public func distinctUntilChanged() -> CallbackW<T> {
    return distinctUntilChanged({$0.asTry().value != $1.asTry().value})
  }
}
