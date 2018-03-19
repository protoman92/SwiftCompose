//
//  FunctionWrapperType.swift
//  SwiftCompose
//
//  Created by Hai Pham on 19/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

/// Represents something that can be converted to a function.
public protocol FunctionWrapperConvertibleType {
  associatedtype T
  associatedtype R

  func asFunctionWrapper() -> FunctionW<T, R>
}

/// FunctionWrapperType represents a wrapper for a Function.
public protocol FunctionWrapperType: FunctionWrapperConvertibleType {
  var function: Function<T, R> { get }

  init(_ function: @escaping Function<T, R>)
}

public extension FunctionWrapperType {
  public func invoke(_ value: T) throws -> R {
    return try function(value)
  }
}
