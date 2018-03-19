//
//  FailableCallbackW+Types.swift
//  SwiftCompose
//
//  Created by Hai Pham on 19/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP

/// Specialized form of Callback.
public typealias FailableCallback<TC: TryConvertibleType> = Callback<TC>
