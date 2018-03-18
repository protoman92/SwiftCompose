//
//  SupplyComposable+Retry.swift
//  SwiftCompose
//
//  Created by Hai Pham on 15/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

public extension SupplyComposable {

  /// Retry wraps an error-returning function with retry capabilities. It
  /// also keeps track of the current retry count, which may be useful if we
  /// want to define a custom retry delay function.
  ///
  /// - Parameter times: The number of times to retry.
  /// - Returns: A custom higher order function.
  public static func retryWithCount(_ times: Int) -> (@escaping (Int) throws -> T) -> SupplierW<T> {
    assert(times >= 0, "Expected retry to be more than 0, but got \(times)")

    return {(s: @escaping (Int) throws -> T) -> SupplierW<T> in
      return SupplierW({
        var current = 0

        while true {
          do {
            return try s(current)
          } catch let e {
            if current == times {
              throw e
            }
          }

          current += 1
        }
      })
    }
  }

  /// Retry has the same semantics as retryWithCount, but ignores the current
  /// retry count.
  ///
  /// - Parameter times: The number of times to retry.
  /// - Returns: A Composable instance.
  public static func retry(_ times: Int) -> SupplyComposable<T> {
    let ss = {(s: @escaping Supplier<T>) -> Supplier<T> in
      let fCount: (Int) throws -> T = {_ in try s()}
      return {try retryWithCount(times)(fCount).invoke()}
    }

    return SupplyComposable(ss)
  }

  /// Curry to provide retry and delay capabilities. Provide seconds for the
  /// time duration.
  ///
  /// - Parameter times: The number of times to retry.
  /// - Returns: A custom higher order function.
  public static func retryWithDelay(_ times: Int) -> (TimeInterval) -> SupplyComposable<T> {
    return {(d: TimeInterval) -> SupplyComposable<T> in
      let ss: SupplierF<T> = {(s: @escaping Supplier<T>) -> Supplier<T> in
        return {
          try retryWithCount(times)({
            if $0 > 0 { Thread.sleep(forTimeInterval: d) }
            return try s()
          }).invoke()
        }
      }

      return SupplyComposable(ss)
    }
  }
}
