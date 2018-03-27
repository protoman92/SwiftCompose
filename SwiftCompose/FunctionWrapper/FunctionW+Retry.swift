//
//  FunctionW+Retry.swift
//  SwiftCompose
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

#if DEBUG
private func retryDesc(_ times: Int) -> String {
  return "Added retry for \(times)"
}

private func retryWithDelayDesc(_ t: Int, _ d: TimeInterval) -> String {
  return "Added retry for \(t) with \(d) delay between retries"
}
#endif

public extension FunctionFWrapperType {
  /// Retry wraps an error-returning function with retry capabilities. It also
  /// keeps track of the current retry count, which may be useful if we want to
  /// define a custom retry delay function.
  ///
  /// - Parameter times: The number of times to retry.
  /// - Returns: A custom higher order function.
  public static func retryWithCount(_ times: Int) -> (@escaping (Int, T) throws -> R) -> Function<T, R> {
    assert(times >= 0, "Expected retry to be more than 0, but got \(times)")

    return {(s: @escaping (Int, T) throws -> R) -> Function<T, R> in
      return {
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
      }
    }
  }

  /// Retry a function with the specified number of retries.
  ///
  /// - Parameter times: An Int value.
  /// - Returns: A Self instance.
  public static func retry(_ times: Int) -> Self {
    let ff: FunctionF<T, R> = {(f: @escaping Function<T, R>) in
      Self.retryWithCount(times)({try f($1)})
    }

    #if DEBUG
    let description = retryDesc(times)
    return Self(ff, description)
    #else
    return Self(ff)
    #endif
  }

  /// Curry to provide retry and delay capabilities. Provide seconds for the
  /// time duration.
  ///
  /// - Parameter times: The number of times to retry.
  /// - Returns: A custom higher order function.
  public static func retryWithDelay(_ times: Int) -> (TimeInterval) -> Self {
    return {(d: TimeInterval) -> Self in
      let ff = {(f: @escaping Function<T, R>) -> Function<T, R> in
        return {
          return try Self.retryWithCount(times)({
            if $0 > 0 { Thread.sleep(forTimeInterval: d) }
            return try f($1)
          })($0)
        }
      }

      #if DEBUG
      return Self(ff, retryWithDelayDesc(times, d))
      #else
      return Self(ff)
      #endif
    }
  }
}

public extension FunctionWrapperType {

  /// Retry the current function up to the specified retry count.
  ///
  /// - Parameter times: The number of times to retry.
  /// - Returns: A Self instance.
  public func retry(_ times: Int) -> Self {
    let f = FunctionFW<T, R>.retry(times).wrap(self.f).f

    #if DEBUG
    let description = appendDescription(retryDesc(times))
    return Self(f, description)
    #else
    return Self(f)
    #endif
  }

  /// Curry to provide retry and delay capabilities. Provide seconds for the
  /// time duration.
  ///
  /// - Parameter times: The number of times to retry.
  /// - Returns: A custom higher order function.
  public func retryWithDelay(_ times: Int) -> (TimeInterval) -> Self {
    return {(d: TimeInterval) in
      let f = FunctionFW<T, R>.retryWithDelay(times)(d).wrap(self.f).f

      #if DEBUG
      let description = self.appendDescription(retryWithDelayDesc(times, d))
      return Self(f, description)
      #else
      return Self(f)
      #endif
    }
  }
}

