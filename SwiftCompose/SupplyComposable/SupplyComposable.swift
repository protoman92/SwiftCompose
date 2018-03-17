//
//  SupplyComposable.swift
//  SwiftCompose
//
//  Created by Hai Pham on 14/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP

/// SupplyComposable represents a function wrapper that can compose with other
/// SupplyComposables to enhance the wrapped Supplier function.
public struct SupplyComposable<T> {
  private let sf: SupplierF<T>

  public init(_ sf: @escaping SupplierF<T>) {
    self.sf = sf
  }

  /// Invoke the inner SupplierF.
  ///
  /// - Parameter s: A Supplier instance.
  /// - Returns: A Supplier instance.
  /// - Throws: If the operation fails.
  public func wrap(_ s: @escaping Supplier<T>) throws -> Supplier<T> {
    return try sf(s)
  }

  /// Invoke the inner Supplier asynchronously with a provided DispatchQueue
  /// and callbacks. The DispatchQueue will be used to schedule the work to be
  /// done by the supplier.
  ///
  /// - Parameter onNext: A T callback function.
  /// - Throws: If the operation fails.
  public func wrapAsync(_ onNext: @escaping (Try<T>) -> Void)
    -> (DispatchQueue)
    -> (@escaping Supplier<T>)
    -> () -> Void
  {
    return {(dq: DispatchQueue) in
      return {(s: @escaping Supplier<T>) in
        return {
          dq.async {
            do {
              try onNext(Try.success(self.wrap(s)()))
            } catch let e {
              onNext(Try.failure(e))
            }
          }
        }
      }
    }
  }

  /// Compose with another SupplierF to enhance functionalities.
  ///
  /// - Parameter sf: A SupplierF instance.
  /// - Returns: A Composable instance.
  public func compose(_ sf: @escaping SupplierF<T>) -> SupplyComposable<T> {
    let newSf: SupplierF<T> = {(s: @escaping Supplier<T>) -> Supplier<T> in
      return try self.wrap(sf(s))
    }

    return SupplyComposable(newSf)
  }

  /// Compose with another Composable to enhance functionalities.
  ///
  /// - Parameter cp: A Composable instance.
  /// - Returns: A Composable instance.
  public func compose(_ cp: SupplyComposable<T>) -> SupplyComposable<T> {
    return compose(cp.sf)
  }
}
