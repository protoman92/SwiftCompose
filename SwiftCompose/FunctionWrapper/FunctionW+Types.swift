//
//  FuncComposable+Types.swift
//  SwiftCompose
//
//  Created by Hai Pham on 17/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

/// Function represents a function that maps one thing to another.
public typealias Function<T, R> = (T) throws -> R

/// PairFunction represents a function that pairs two arguments and return
/// another type.
public typealias PairFunction<T, R> = (T?, T) throws -> R

/// FunctionF maps a Function to a Function.
public typealias FunctionF<T, R> = (@escaping Function<T, R>) throws -> Function<T, R>
