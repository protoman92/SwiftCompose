//
//  FailableCallbackWrapperType.swift
//  SwiftCompose
//
//  Created by Hai Pham on 19/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP

public protocol CallbackTryWrapperType: FunctionWrapperType where T == Try<Val> {
  associatedtype Val
}
