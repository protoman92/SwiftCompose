//
//  FuncComposable.swift
//  SwiftCompose
//
//  Created by Hai Pham on 17/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

/// FuncComposable represents a function wrapper that can be composed with other
/// FuncComposables.
public struct FuncComposable<T, R> {
  private let ff: FunctionF<T, R>

  public init(_ ff: @escaping FunctionF<T, R>) {
    self.ff = ff
  }
}
