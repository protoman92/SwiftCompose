//
//  FunctionW+Retry.swift
//  SwiftCompose
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

public extension FunctionWrapperType {

  /// Retry wraps an error-returning function with retry capabilities. It
  /// also keeps track of the current retry count, which may be useful if we
  /// want to define a custom retry delay function.
  ///
  /// - Parameter times: The number of times to retry.
  /// - Returns: A custom higher order function.
  public static func retryWithCount(_ times: Int) -> (@escaping (Int, T) throws -> R) -> Self {
    assert(times >= 0, "Expected retry to be more than 0, but got \(times)")

    return {(s: @escaping (Int, T) throws -> R) -> Self in
      let function: Function<T, R> = ({
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

      #if DEBUG
        let description = "Added retry for \(times) times"
        return Self(function, description)
      #else
        return Self(function)
      #endif
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
  /// - Returns: A Self instance.
  public func retry(_ times: Int) -> Self {
    let retried = Self.retryWithCount(times)({try self.invoke($1)})

    #if DEBUG
      let function: Function<T, R> = {try retried.invoke($0)}
      let description = appendDescription(retried.description)
      return Self(function, description)
    #else
      return retried
    #endif
  }

  /// Curry to provide retry and delay capabilities. Provide seconds for the
  /// time duration.
  ///
  /// - Parameter times: The number of times to retry.
  /// - Returns: A custom higher order function.
  public func retryWithDelay(_ times: Int) -> (TimeInterval) -> Self {
    return {(d: TimeInterval) in
      let function: Function<T, R> = {
        try FunctionW.retryWithDelay(times)(d)(self.function)($0)
      }

      #if DEBUG
        let description = self.appendDescription("" +
          "Added retry for \(times) " +
          "with \(d) delay between retries")

        return Self(function, description)
      #else
        return Self(function)
      #endif
    }
  }
}

