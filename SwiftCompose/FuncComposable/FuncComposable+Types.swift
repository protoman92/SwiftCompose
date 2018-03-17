//
//  FuncComposable+Types.swift
//  SwiftCompose
//
//  Created by Hai Pham on 17/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

/// Function represents a function that maps one thing to another.
public typealias Function<T, R> = (T) throws -> R

/// FunctionF represents a function that maps one Function to another.
public typealias FunctionF<T, R> = (@escaping Function<T, R>) throws -> Function<T, R>
