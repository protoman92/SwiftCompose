//
//  FailableCallbackWrapperType.swift
//  SwiftCompose
//
//  Created by Hai Pham on 19/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP

/// Represents a callback that has a Try/Optional as the input argument.
public protocol FailableCallbackWrapperType: CallbackWrapperType where T: TryConvertibleType, T.Val == Val {
  associatedtype Val
}
