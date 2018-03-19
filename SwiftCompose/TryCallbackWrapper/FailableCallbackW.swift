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

  public init(_ callback: @escaping FailableCallback<TC>) {
    self.function = callback
  }
}

extension FailableCallbackW: FunctionWrapperConvertibleType {
  public typealias T = TC
  public typealias R = Void

  public func asFunctionWrapper() -> FunctionW<TC, Void> {
    return FunctionW(function)
  }
}

extension FailableCallbackW: CallbackWrapperConvertibleType {
  public func asCallbackWrapper() -> CallbackW<TC> {
    return CallbackW(function)
  }
}

extension FailableCallbackW: CallbackWrapperType {}

extension FailableCallbackW: FailableCallbackWrapperType {
  public typealias Val = TC.Val
}
