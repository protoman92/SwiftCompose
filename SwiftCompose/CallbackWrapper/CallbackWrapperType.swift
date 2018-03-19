//
//  CallbackWrapperType.swift
//  SwiftCompose
//
//  Created by Hai Pham on 19/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

/// Represents something that can be converted to a callback wrapper.
public protocol CallbackWrapperConvertibleType: FunctionWrapperConvertibleType where R == Void {
  func asCallbackWrapper() -> CallbackW<T>
}

/// Represents a callback wrapper.
public protocol CallbackWrapperType: CallbackWrapperConvertibleType, FunctionWrapperType {}
