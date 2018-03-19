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

  #if DEBUG
    public let description: String

    public init(_ callback: @escaping Callback<T>, _ description: String) {
      self.description = description
      self.function = callback
    }
  #endif

  public init(_ callback: @escaping Callback<T>) {
    self.function = callback

    #if DEBUG
      description = String(describing: CallbackW.self)
    #endif
  }
}

extension CallbackW: FunctionWrapperConvertibleType {
  public func asFunctionWrapper() -> FunctionW<T, Void> {
    #if DEBUG
      return FunctionW(function, description)
    #else
      return FunctionW(function)
    #endif
  }
}

extension CallbackW: CallbackWrapperConvertibleType {
  public func asCallbackWrapper() -> CallbackW<T> {
    return self
  }
}

extension CallbackW: CallbackWrapperType {}

#if DEBUG
  extension CallbackW: CustomStringConvertible {}
#endif

public extension FunctionW where R == Void {

  /// Convert the current function wrapper to a callback wrapper.
  ///
  /// - Returns: A CallbackW instance.
  public func asCallbackWrapper() -> CallbackW<T> {
    #if DEBUG
      return CallbackW(function, description)
    #else
      return CallbackW(function)
    #endif
  }
}
