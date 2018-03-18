//
//  FuncComposable+Map.swift
//  SwiftCompose
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

public extension FuncComposable {

  /// Map the argument of a Function to another type.
  ///
  /// - Parameter m: Mapper function.
  /// - Returns: A Function instance.
  public static func mapArg<T1>(_ m: @escaping (T) throws -> T1)
    -> (@escaping Function<T1, R>)
    -> Function<T, R>
  {
    return {(f1: @escaping Function<T1, R>) in return {try f1(m($0))}}
  }
}

