//
//  FailableCallbackW.swift
//  SwiftCompose
//
//  Created by Hai Pham on 19/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP

public struct FailableCallbackW<TC: TryConvertibleType> {
  public var f: FailableCallback<TC>

  #if DEBUG
  public let description: String

  public init(_ callback: @escaping FailableCallback<TC>, _ description: String) {
    self.f = callback
    self.description = description
  }
  #endif

  public init(_ callback: @escaping FailableCallback<TC>) {
    self.f = callback

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
    return FunctionW(f, description)
    #else
    return FunctionW(f)
    #endif
  }
}

extension FailableCallbackW: CallbackWrapperConvertibleType {
  public func asCallbackWrapper() -> CallbackW<TC> {
    #if DEBUG
    return CallbackW(f, description)
    #else
    return CallbackW(f)
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
    return FailableCallbackW(f, description)
    #else
    return FailableCallbackW(f)
    #endif
  }
}

