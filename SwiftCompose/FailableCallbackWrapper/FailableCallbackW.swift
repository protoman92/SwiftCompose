//
//  FailableCallbackW.swift
//  SwiftCompose
//
//  Created by Hai Pham on 19/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP

public struct FailableCallbackW<TC: TryConvertibleType> {
  public var function: FailableCallback<TC>

  #if DEBUG
    public let description: String

    public init(_ callback: @escaping FailableCallback<TC>, _ description: String) {
      self.description = description
      self.function = callback
    }
  #endif

  public init(_ callback: @escaping FailableCallback<TC>) {
    self.function = callback

    #if DEBUG
      description = String(describing: FailableCallbackW.self)
    #endif
  }
}

extension FailableCallbackW: FunctionWrapperConvertibleType {
  public typealias T = TC
  public typealias R = Void

  public func asFunctionWrapper() -> FunctionW<TC, Void> {
    #if DEBUG
      return FunctionW(function, description)
    #else
      return FunctionW(function)
    #endif
  }
}

extension FailableCallbackW: CallbackWrapperConvertibleType {
  public func asCallbackWrapper() -> CallbackW<TC> {
    #if DEBUG
      return CallbackW(function, description)
    #else
      return CallbackW(function)
    #endif
  }
}

extension FailableCallbackW: CallbackWrapperType {}

extension FailableCallbackW: FailableCallbackWrapperType {
  public typealias Val = TC.Val
}

#if DEBUG
  extension FailableCallbackW: CustomStringConvertible {}
#endif

public extension CallbackW where T: TryConvertibleType {

  /// Convert the current callback wrapper to a failable callback wrapper.
  ///
  /// - Returns: A FailableCallbackW instance.
  public func asFailableCallbackWrapper() -> FailableCallbackW<T> {
    #if DEBUG
      return FailableCallbackW(function, description)
    #else
      return FailableCallbackW(function)
    #endif
  }
}

