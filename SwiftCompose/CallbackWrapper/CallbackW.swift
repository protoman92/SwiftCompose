//
//  CallbackW.swift
//  SwiftCompose
//
//  Created by Hai Pham on 19/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

/// Wrapper for a callback function.
public struct CallbackW<T> {
  public var function: Callback<T>

  public init(_ callback: @escaping Callback<T>) {
    self.function = callback
  }
}

extension CallbackW: FunctionWrapperConvertibleType {
  public func asFunctionWrapper() -> FunctionW<T, Void> {
    return FunctionW(function)
  }
}

extension CallbackW: CallbackWrapperConvertibleType {
  public func asCallbackWrapper() -> CallbackW<T> {
    return self
  }
}

extension CallbackW: CallbackWrapperType {}

public extension FunctionW where R == Void {

  /// Convert the current function wrapper to a callback wrapper.
  ///
  /// - Returns: A CallbackW instance.
  public func asCallbackWrapper() -> CallbackW<T> {
    return CallbackW(function)
  }
}
