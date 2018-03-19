//
//  SupplierWrapperType.swift
//  SwiftCompose
//
//  Created by Hai Pham on 19/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

/// Represents something that can be converted to a supplier wrapper.
public protocol SupplierWrapperConvertibleType: FunctionWrapperConvertibleType where T == Void {
  func asSupplierWrapper() -> SupplierW<R>
}

/// Wrapper for supplier.
public protocol SupplierWrapperType: SupplierWrapperConvertibleType, FunctionWrapperType {}
