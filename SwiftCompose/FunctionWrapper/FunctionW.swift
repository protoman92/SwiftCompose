//
//  FunctionW.swift
//  SwiftCompose
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

/// Wrapper for Function.
public struct FunctionW<T, R> {
  public let function: Function<T, R>

  public init(_ f: @escaping Function<T, R>) {
    self.function = f
  }
}

extension FunctionW: FunctionWrapperConvertibleType {
  public func asFunctionWrapper() -> FunctionW<T, R> {
    return self
  }
}

extension FunctionW: FunctionWrapperType {}
