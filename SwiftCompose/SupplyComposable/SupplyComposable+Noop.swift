//
//  SupplyComposable+Noop.swift
//  SwiftCompose
//
//  Created by Hai Pham on 15/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

public extension SupplyComposable {

  /// Noop does nothing an simply returns whatever is passed in.
  ///
  /// - Returns: A SupplierF instance.
  public static func noop() -> SupplierF<T> {
    return {$0}
  }
}
