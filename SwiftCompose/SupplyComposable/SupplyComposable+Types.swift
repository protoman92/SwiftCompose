//
//  Types.swift
//  SwiftCompose
//
//  Created by Hai Pham on 16/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

import SwiftFP

/// AsyncCallback represents a callback for an asynchronous function.
public typealias AsyncCallback<T> = (Try<T>) -> Void

/// AsyncOperation represents an asynchronous operation.
public typealias AsyncOperation<T> = (@escaping AsyncCallback<T>) -> Void

/// Supplier represents a function that returns some data.
public typealias Supplier<T> = () throws -> T

/// SupplierF represents a function that maps a Supplier to another Supplier.
public typealias SupplierF<T> = (@escaping Supplier<T>) throws -> Supplier<T>
