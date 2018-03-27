//
//  FunctionW+Log.swift
//  SwiftCompose
//
//  Created by Hai Pham on 19/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

public extension FunctionFWrapperType {

  /// Log the result of the operation.
  ///
  /// - Parameter selector: Selector function.
  /// - Returns: A Self instance.
  public static func logValue<R1>(_ selector: @escaping Function<R, R1>) -> Self {
    return publish({
      #if DEBUG
      try print(selector($0))
      #endif
    })
  }

  /// Log the result of the operation without transforming it.
  ///
  /// - Returns: A Self instance.
  public static func logValue() -> Self {
    return logValue({$0})
  }

  /// Log the result of the operation with a prefix.
  ///
  /// - Parameters:
  ///   - prefix: A String value.
  ///   - selector: Selector function.
  /// - Returns: A Self instance.
  public static func logValuePrefix<R1>(_ prefix: String, _ selector: @escaping Function<R, R1>) -> Self {
    return logValue({"\(prefix)\(try selector($0))"})
  }

  /// Log the result of the operation with a prefix, without transforming it.
  ///
  /// - Parameter prefix: A String value.
  /// - Returns: A Self instance.
  public static func logValuePrefix(_ prefix: String) -> Self {
    return logValuePrefix(prefix, {$0})
  }

  /// Log the input arguments.
  ///
  /// - Parameter selector: Selector function.
  /// - Returns: A Self instance.
  public static func logArgs<T1>(_ selector: @escaping Function<T, T1>) -> Self {
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
  public static func logArgsPrefix<T1>(_ prefix: String, _ selector: @escaping Function<T, T1>) -> Self {
    return logArgs({"\(prefix)\(try selector($0))"})
  }

  /// Log the input arguments with a prefix, without transforming it.
  ///
  /// - Parameter prefix: A String value.
  /// - Returns: A Self instance.
  public static func logArgsPrefix(_ prefix: String) -> Self {
    return logArgsPrefix(prefix, {$0})
  }

  /// Log the input arguments without transforming it.
  ///
  /// - Returns: A Self instance.
  public static func logArgs() -> Self {
    return logArgs({$0})
  }
}

public extension FunctionWrapperType {

  /// Log the result of the operation.
  ///
  /// - Parameter selector: Selector function.
  /// - Returns: A Self instance.
  public func logValue<R1>(_ selector: @escaping Function<R, R1>) -> Self {
    let f = FunctionFW<T, R>.logValue(selector).wrap(self.f).f

    #if DEBUG
    let description = appendDescription("Added logValue with selector")
    return Self(f, description)
    #else
    return Self(f)
    #endif
  }

  /// Log the result of the operation without transforming it.
  ///
  /// - Returns: A Self instance.
  public func logValue() -> Self {
    let f = FunctionFW<T, R>.logValue().wrap(self.f).f

    #if DEBUG
    let description = appendDescription("Added logValue")
    return Self(f, description)
    #else
    return Self(f)
    #endif
  }

  /// Log the result of the operation with a prefix.
  ///
  /// - Parameters:
  ///   - prefix: A String value.
  ///   - selector: Selector function.
  /// - Returns: A Self instance.
  public func logValuePrefix<R1>(_ prefix: String, _ selector: @escaping Function<R, R1>) -> Self {
    let f = FunctionFW<T, R>.logValuePrefix(prefix, selector).wrap(self.f).f

    #if DEBUG
    let description = appendDescription("Added logValuePrefix with selector")
    return Self(f, description)
    #else
    return Self(f)
    #endif
  }

  /// Log the result of the operation with a prefix, without transforming it.
  ///
  /// - Parameter prefix: A String value.
  /// - Returns: A Self instance.
  public func logValuePrefix(_ prefix: String) -> Self {
    let f = FunctionFW<T, R>.logValuePrefix(prefix).wrap(self.f).f

    #if DEBUG
    let description = appendDescription("Added logValuePrefix")
    return Self(f, description)
    #else
    return Self(f)
    #endif
  }

  /// Log the input arguments.
  ///
  /// - Parameter selector: Selector function.
  /// - Returns: A Self instance.
  public func logArgs<T1>(_ selector: @escaping Function<T, T1>) -> Self {
    let f = FunctionFW<T, R>.logArgs(selector).wrap(self.f).f

    #if DEBUG
    let description = appendDescription("Added logArgs with selector")
    return Self(f, description)
    #else
    return Self(f)
    #endif
  }

  /// Log the input arguments with a prefix.
  ///
  /// - Parameters:
  ///   - prefix: A String value.
  ///   - selector: Selector function.
  /// - Returns: A Self instance.
  public func logArgsPrefix<T1>(_ prefix: String, _ selector: @escaping Function<T, T1>) -> Self {
    let f = FunctionFW<T, R>.logArgsPrefix(prefix, selector).wrap(self.f).f

    #if DEBUG
    let description = appendDescription("Added logArgsPrefix with selector")
    return Self(f, description)
    #else
    return Self(f)
    #endif
  }

  /// Log the input arguments with a prefix, without transforming it.
  ///
  /// - Parameter prefix: A String value.
  /// - Returns: A Self instance.
  public func logArgsPrefix(_ prefix: String) -> Self {
    let f = FunctionFW<T, R>.logArgsPrefix(prefix).wrap(self.f).f

    #if DEBUG
    let description = appendDescription("Added logArgsPrefix")
    return Self(f, description)
    #else
    return Self(f)
    #endif
  }

  /// Log the input arguments without transforming it.
  ///
  /// - Returns: A Self instance.
  public func logArgs() -> Self {
    let f = FunctionFW<T, R>.logArgs().wrap(self.f).f

    #if DEBUG
    let description = appendDescription("Added logArgs")
    return Self(f, description)
    #else
    return Self(f)
    #endif
  }
}
