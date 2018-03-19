//
//  FailableCallbackW+Skip.swift
//  SwiftCompose
//
//  Created by Hai Pham on 19/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP

public extension FailableCallbackWrapperType where T == Optional<Val> {

  /// Skip nil input arguments.
  ///
  /// - Returns: A CallbackW instance with unwrapped input argument.
  public func skipNils() -> CallbackW<Val> {
    return mapArg({(a: Val) in Optional.some(a)}).asCallbackWrapper()
  }
}

public extension FailableCallbackWrapperType where T == Try<Val> {

  /// Skip failure input arguments.
  ///
  /// - Returns: A CallbackW instance with unwrapped input argument.
  public func skipFailures() -> CallbackW<Val> {
    return mapArg({(a: Val) in Try.success(a)}).asCallbackWrapper()
  }
}

