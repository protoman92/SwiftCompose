//
//  SupplierW.swift
//  SwiftCompose
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

/// Wrapper for a supplier function.
public struct SupplierW<R> {
  public var function: Function<Void, R>

  public init(_ supplier: @escaping Function<Void, R>) {
    self.function = supplier
  }

  public func invoke() throws -> R {
    return try invoke(())
  }
}

extension SupplierW: FunctionWrapperConvertibleType {
  public func asFunctionWrapper() -> FunctionW<Void, R> {
    return FunctionW(function)
  }
}

extension SupplierW: SupplierWrapperType {}

public extension FunctionW where T == Void {

  /// Convert the current function wrapper to a supplier wrapper.
  ///
  /// - Returns: A SupplierW instance.
  public func toSupplierWrapper() -> SupplierW<R> {
    return SupplierW(function)
  }
}
