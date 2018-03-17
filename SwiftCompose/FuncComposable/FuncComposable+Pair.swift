//
//  File.swift
//  SwiftCompose
//
//  Created by Hai Pham on 17/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

public extension FuncComposable {

  /// Tracks the last value that was supplied as an argument, and include it
  /// together with the pair function.
  ///
  /// - Parameter pairF: A pairing function.
  /// - Returns: A Function instance.
  public static func pair(_ pairF: @escaping (T?, T) throws -> R) -> Function<T, R> {
    var lastValue: StrongReference<T>?

    return {
      let oldLastValue = lastValue
      lastValue = StrongReference($0)
      return try pairF(oldLastValue?.value, $0)
    }
  }
}

