//
//  FunctionW+Timeout.swift
//  SwiftCompose
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP

public extension FunctionWrapperType {

  /// Times out an operation with a timeout error. For the second curried
  /// parameter, provide the DispatchQueue to run the operation on. The
  /// result will be received on the calling thread, so beware which queue
  /// is passed in, because using the wrong dispatch queue may block forever.
  ///
  /// For example, it will block if both the calling queue and the perform
  /// queue are main. If both are backgrounds, or one main one background, it
  /// should be fine.
  ///
  /// - Parameter duration: A TimeInterval value.
  /// - Returns: A custom higher order function.
  public static func timeout(_ duration: TimeInterval) -> (DispatchQueue) -> FunctionF<T, R> {
    return {(dq: DispatchQueue) -> FunctionF<T, R> in
      return {(s: @escaping Function<T, R>) -> Function<T, R> in
        return {(v: T) in
          let dispatchGroup = DispatchGroup()
          var result: StrongReference<Try<R>>?
          dispatchGroup.enter()

          dq.async {
            result = StrongReference(Try<R>({try s(v)}))
            dispatchGroup.leave()
          }

          _ = dispatchGroup.wait(timeout: DispatchTime.now() + duration)

          if let resultF = result {
            return try resultF.value.getOrThrow()
          } else {
            throw FPError("Timed out after \(duration)")
          }
        }
      }
    }
  }

  /// Convenience method to provide timeout functionalities.
  ///
  /// - Parameter duration: A TimeInterval value.
  /// - Returns: A custom higher order function.
  public func timeout(_ duration: TimeInterval) -> (DispatchQueue) -> Self {
    return {(dq: DispatchQueue) in Self({
        try FunctionW.timeout(duration)(dq)(self.function)($0)
    })}
  }
}
