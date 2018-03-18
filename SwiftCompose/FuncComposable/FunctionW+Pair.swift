//
//  FunctionW+Pair.swift
//  SwiftCompose
//
//  Created by Hai Pham on 17/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

public extension FunctionW {

  /// Tracks the last value that was supplied as an argument, and include it
  /// together with the pair function.
  ///
  /// - Parameter pairF: A pairing function.
  /// - Returns: A FuncPairComposable instance.
  public static func pair(_ pairF: @escaping PairFunction<T, R>) -> FunctionW<T, R> {
    var lastValue: StrongReference<T>?

    return FunctionW({
      let oldLastValue = lastValue
      lastValue = StrongReference($0)
      return try pairF(oldLastValue?.value, $0)
    })
  }
}
