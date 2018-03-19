//
//  FunctionW+Log.swift
//  SwiftCompose
//
//  Created by Hai Pham on 19/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

public extension FunctionWrapperType {

  /// Log the result of the operation.
  ///
  /// - Parameter selector: Selector function.
  /// - Returns: A Self instance.
  public func logValue<R1>(_ selector: @escaping Function<R, R1>) -> Self {
    return publish({
      #if DEBUG
        try print(selector($0))
      #endif
    })
  }

  /// Log the result of the operation with a prefix.
  ///
  /// - Parameters:
  ///   - prefix: A String value.
  ///   - selector: Selector function.
  /// - Returns: A Self instance.
  public func logValuePrefix<R1>(_ prefix: String, _ selector: @escaping Function<R, R1>) -> Self {
    return logValue({"\(prefix)\(try selector($0))"})
  }

  /// Log the result of the operation with a prefix, without transforming it.
  ///
  /// - Parameter prefix: A String value.
  /// - Returns: A Self instance.
  public func logValuePrefix(_ prefix: String) -> Self {
    return logValuePrefix(prefix, {$0})
  }

  /// Log the result of the operation without transforming it.
  ///
  /// - Returns: A Self instance.
  public func logValue() -> Self {
    return logValue({$0})
  }

  /// Log the input arguments.
  ///
  /// - Parameter selector: Selector function.
  /// - Returns: A Self instance.
  public func logArgs<T1>(_ selector: @escaping Function<T, T1>) -> Self {
    return publishArgs({
      #if DEBUG
        try print(selector($0))
      #endif
    })
  }

  /// Log the input arguments with a prefix.
  ///
  /// - Parameters:
  ///   - prefix: A String value.
  ///   - selector: Selector function.
  /// - Returns: A Self instance.
  public func logArgsPrefix<T1>(_ prefix: String, _ selector: @escaping Function<T, T1>) -> Self {
    return logArgs({"\(prefix)\(try selector($0))"})
  }

  /// Log the input arguments with a prefix, without transforming it.
  ///
  /// - Parameter prefix: A String value.
  /// - Returns: A Self instance.
  public func logArgsPrefix(_ prefix: String) -> Self {
    return logArgsPrefix(prefix, {$0})
  }

  /// Log the input arguments without transforming it.
  ///
  /// - Returns: A Self instance.
  public func logArgs() -> Self {
    return logArgs({$0})
  }
}
