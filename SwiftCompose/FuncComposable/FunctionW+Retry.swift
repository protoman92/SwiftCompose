//
//  FunctionW+Retry.swift
//  SwiftCompose
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

public extension FunctionW {

  /// Retry wraps an error-returning function with retry capabilities. It
  /// also keeps track of the current retry count, which may be useful if we
  /// want to define a custom retry delay function.
  ///
  /// - Parameter times: The number of times to retry.
  /// - Returns: A custom higher order function.
  public static func retryWithCount(_ times: Int) -> (@escaping (Int, T) throws -> R) -> FunctionW<T, R> {
    assert(times >= 0, "Expected retry to be more than 0, but got \(times)")

    return {(s: @escaping (Int, T) throws -> R) -> FunctionW<T, R> in
      return FunctionW({
        var current = 0

        while true {
          do {
            return try s(current, $0)
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

  /// Curry to provide retry and delay capabilities. Provide seconds for the
  /// time duration.
  ///
  /// - Parameter times: The number of times to retry.
  /// - Returns: A custom higher order function.
  public static func retryWithDelay(_ times: Int) -> (TimeInterval) -> FunctionF<T, R> {
    return {(d: TimeInterval) -> FunctionF<T, R> in
      return {(f: @escaping Function<T, R>) -> Function<T, R> in
        return {
          return try retryWithCount(times)({
            if $0 > 0 { Thread.sleep(forTimeInterval: d) }
            return try f($1)
          }).invoke($0)
        }
      }
    }
  }

  /// Retry the current function up to the specified retry count.
  ///
  /// - Parameter times: The number of times to retry.
  /// - Returns: A FunctionW instance.
  public func retry(_ times: Int) -> FunctionW<T, R> {
    return FunctionW.retryWithCount(times)({try self.invoke($1)})
  }

  /// Curry to provide retry and delay capabilities. Provide seconds for the
  /// time duration.
  ///
  /// - Parameter times: The number of times to retry.
  /// - Returns: A custom higher order function.
  public func retryWithDelay(_ times: Int) -> (TimeInterval) -> FunctionW<T, R> {
    return {(d: TimeInterval) in
      return FunctionW{try FunctionW.retryWithDelay(times)(d)(self.function)($0)}
    }
  }
}

