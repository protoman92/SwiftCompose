//
//  Composable+Timeout.swift
//  SwiftCompose
//
//  Created by Hai Pham on 15/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP

public extension Composable {

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
  /// - Returns: A Composable instance.
  public static func timeout(_ duration: TimeInterval) -> (DispatchQueue) -> Composable<T> {
    return {(dq: DispatchQueue) -> Composable<T> in
      let sf: SupplierF<T> = {(s: @escaping Supplier<T>) -> Supplier<T> in
        return {
          let dispatchGroup = DispatchGroup()
          var result: Try<T>?
          dispatchGroup.enter()

          dq.async {
            result = Try(s)
            dispatchGroup.leave()
          }

          _ = dispatchGroup.wait(timeout: DispatchTime.now() + duration)

          if let resultF = result {
            return try resultF.getOrThrow()
          } else {
            throw FPError("Timed out after \(duration)")
          }
        }
      }

      return Composable(sf)
    }
  }
}
