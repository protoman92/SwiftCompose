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

  #if DEBUG
    public let description: String

    public init(_ supplier: @escaping Function<Void, R>, _ description: String) {
      self.description = description
      self.function = supplier
    }
  #endif

  public init(_ supplier: @escaping Function<Void, R>) {
    self.function = supplier

    #if DEBUG
      description = String(describing: SupplierW.self)
    #endif
  }

  public func invoke() throws -> R {
    return try invoke(())
  }
}

extension SupplierW: FunctionWrapperConvertibleType {
  public func asFunctionWrapper() -> FunctionW<Void, R> {
    #if DEBUG
      return FunctionW(function, description)
    #else
      return FunctionW(function)
    #endif
  }
}

extension SupplierW: SupplierWrapperConvertibleType {
  public func asSupplierWrapper() -> SupplierW<R> {
    #if DEBUG
      return SupplierW(function, description)
    #else
      return SupplierW(function)
    #endif
  }
}

extension SupplierW: SupplierWrapperType {}

#if DEBUG
  extension SupplierW: CustomStringConvertible {}
#endif

public extension FunctionW where T == Void {

  /// Convert the current function wrapper to a supplier wrapper.
  ///
  /// - Returns: A SupplierW instance.
  public func asSupplierWrapper() -> SupplierW<R> {
    #if DEBUG
      return SupplierW(function, description)
    #else
      return SupplierW(function)
    #endif
  }
}
