//
//  Composable+Zip.swift
//  SwiftCompose
//
//  Created by Hai Pham on 16/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

public extension Composable {

	/// Zip the results of a Sequence of Suppliers.
	///
	/// - Parameter z: Zipper function.
	/// - Returns: A custom higher-order function.
	public static func zip(_ z: @escaping ([T]) throws -> T) -> ([Supplier<T>]) -> Supplier<T> {
		return {(ss: [Supplier<T>]) in
			return {try z(ss.map({try $0()}))}
		}
	}

	/// This is similar to zip, but the arguments in the curried function are
	/// variadic.
	///
	/// - Parameter z: Zipper function.
	/// - Returns: A custom higher-order function.
	public static func zipVarargs(_ z: @escaping ([T]) throws -> T) -> (Supplier<T>...) -> Supplier<T> {
		return {(ss: Supplier<T>...) in zip(z)(ss.map({$0}))}
	}
}
