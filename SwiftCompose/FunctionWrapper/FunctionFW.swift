//
//  FunctionFW.swift
//  SwiftCompose
//
//  Created by Hai Pham on 27/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

/// Wrapper for a FunctionF.
public struct FunctionFW<T, R> {
  public let ff: FunctionF<T, R>

  #if DEBUG
  public let description: String

  public init(_ ff: @escaping FunctionF<T, R>, _ description: String) {
    self.ff = ff
    self.description = description
  }
  #endif

  public init(_ ff: @escaping FunctionF<T, R>) {
    self.ff = ff

    #if DEBUG
    self.description = String(describing: FunctionFW.self)
    #endif
  }
}

extension FunctionFW: FunctionFWrapperConvertibleType {
  public func asFunctionFWrapper() -> FunctionFW<T, R> {
    return self
  }
}

extension FunctionFW: FunctionFWrapperType {}

#if DEBUG
extension FunctionFW: CustomStringConvertible {}
#endif
