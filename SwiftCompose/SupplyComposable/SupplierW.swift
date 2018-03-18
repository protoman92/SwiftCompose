//
//  SupplierW.swift
//  SwiftCompose
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

/// Wrapper for a supplier function.
public typealias SupplierW<R> = FunctionW<Void, R>

public extension FunctionW where T == Void {
  public func invoke() throws -> R {
    return try invoke(())
  }
}
