//
//  CallbackW+Filter.swift
//  SwiftCompose
//
//  Created by Hai Pham on 19/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

public extension CallbackWrapperType {

  /// Filter the input argument with a filter selector.
  ///
  /// - Parameter f: Selector function.
  /// - Returns: A Self instance.
  public func filter(_ f: @escaping (T) throws -> Bool) -> Self {
    return Self({
      guard try f($0) else { return  }
      _ = try self.invoke($0)
    })
  }
}
