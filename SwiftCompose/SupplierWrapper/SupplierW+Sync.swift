//
//  SupplierW+Sync.swift
//  SwiftCompose
//
//  Created by Hai Pham on 15/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP

public extension SupplierW {

  /// Synchronize the result of an async operation. It is important that the
  /// calling queue and perform queue have the same constraints as those
  /// spelled out in Composable.timeout(). The returned Supplier can then be
  /// fed to other Composables.
  ///
  /// - Parameter callbackFn: An AsyncCallback instance.
  /// - Returns: A Supplier instance.
  public static func sync(_ callbackFn: @escaping AsyncOperation<R>) -> SupplierW<R> {
    return SupplierW({
      let dispatchGroup = DispatchGroup()
      var result: StrongReference<Try<R>>?

      let callback: AsyncCallback<R> = {(v: Try<R>) -> Void in
        result = StrongReference(v)
        dispatchGroup.leave()
      }

      dispatchGroup.enter()
      callbackFn(callback)
      dispatchGroup.wait()

      if let result = result {
        return try result.value.getOrThrow()
      } else {
        throw FPError("Invalid result/error")
      }
    })
  }
}
