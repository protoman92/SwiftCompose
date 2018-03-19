//
//  FunctionW+Pair.swift
//  SwiftCompose
//
//  Created by Hai Pham on 17/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

public extension FunctionWrapperType {

  /// Tracks the last value that was supplied as an argument, and include it
  /// together with the pair function.
  ///
  /// - Parameter pairF: A pairing function.
  /// - Returns: A Self instance.
  public static func pair(_ pairF: @escaping PairFunction<T, R>) -> Self {
    var lastValue: StrongReference<T>?

    let function: Function<T, R> = ({
      let oldLastValue = lastValue
      lastValue = StrongReference($0)
      return try pairF(oldLastValue?.value, $0)
    })

    #if DEBUG
      let description = "Added pairing with previous value"
      return Self(function, description)
    #else
      return Self(function)
    #endif
  }
}
