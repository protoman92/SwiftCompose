//
//  CallbackW+Distinct.swift
//  SwiftCompose
//
//  Created by Hai Pham on 19/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP

public extension CallbackWrapperType {

  /// Do not invoke the callback while the arguments have not changed.
  ///
  /// - Parameter c: Comparison function. Return true if different.
  /// - Returns: A Self instance.
  public func distinctUntilChanged(_ c: @escaping (T, T) throws -> Bool) -> Self {
    let pairF: PairFunction<T, Void> = {
      if $0 == nil {
        _ = try self.invoke($1)
      } else if let prev = $0, try c(prev, $1) {
        _ = try self.invoke($1)
      }
    }

    let paired = Self.pair(pairF)

    #if DEBUG
    let function: Callback<T> = {try paired.invoke($0)}
    let description = appendDescription(paired.description)
    return Self(function, description)
    #else
    return paired
    #endif
  }
}

public extension CallbackWrapperType where T: Equatable {

  /// Convenience function that makes use of equatability.
  ///
  /// - Returns: A CallbackWrapperType instance.
  public func distinctUntilChanged() -> Self {
    return distinctUntilChanged({$0 != $1})
  }
}

public extension CallbackWrapperType where T: TryConvertibleType, T.Val: Equatable {

  /// Convenience function that makes use of equatability.
  ///
  /// - Returns: A Self instance.
  public func distinctUntilChanged() -> Self {
    return distinctUntilChanged({$0.asTry().value != $1.asTry().value})
  }
}
