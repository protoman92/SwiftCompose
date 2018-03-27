//
//  FunctionW+Timeout.swift
//  SwiftCompose
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP

public extension FunctionFWrapperType {

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
  public static func timeout(_ duration: TimeInterval) -> (DispatchQueue) -> Self {
    return {(dq: DispatchQueue) in
      return Self({(s: @escaping Function<T, R>) in
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
      })
    }
  }
}

public extension FunctionWrapperType {

  /// Convenience method to provide timeout functionalities.
  ///
  /// - Parameter duration: A TimeInterval value.
  /// - Returns: A custom higher order function.
  public func timeout(_ duration: TimeInterval) -> (DispatchQueue) -> Self {
    return {(dq: DispatchQueue) in
      let f = FunctionFW<T, R>.timeout(duration)(dq).wrap(self.f).f

      #if DEBUG
      let description = self.appendDescription("Added timeout for \(duration)")
      return Self(f, description)
      #else
      return Self(f)
      #endif
    }
  }
}
