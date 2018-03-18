//
//  SupplierW.swift
//  SwiftCompose
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

/// Wrapper for a supplier function.
public struct SupplierW<T> {
  public let supplier: Supplier<T>

  public init(_ supplier: @escaping Supplier<T>) {
    self.supplier = supplier
  }

  public func invoke() throws -> T {
    return try supplier()
  }
}
