//
//  SupplierW+Sync.swift
//  SwiftCompose
//
//  Created by Hai Pham on 15/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP

public extension SupplierWrapperType {

  /// Synchronize the result of an async operation. It is important that the
  /// calling queue and perform queue have the same constraints as those
  /// spelled out in Composable.timeout(). The returned Supplier can then be
  /// fed to other Composables.
  ///
  /// - Parameter callbackFn: An AsyncCallback instance.
  /// - Returns: A Self instance.
  public static func sync(_ callbackFn: @escaping AsyncOperation<R>) -> Self {
    let function: Supplier<R> = ({
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

    #if DEBUG
      let description = "Added sync for callback"
      return Self(function, description)
    #else
      return Self(function)
    #endif
  }
}
