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

  public func invoke(_ value: T) throws -> R {
    return try function(value)
  }
}
