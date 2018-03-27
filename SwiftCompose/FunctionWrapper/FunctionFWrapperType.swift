//
//  FunctionFWrapperType.swift
//  SwiftCompose
//
//  Created by Hai Pham on 27/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

/// Represents something that can be converted to a FunctionFW.
public protocol FunctionFWrapperConvertibleType {
  associatedtype T
  associatedtype R

  func asFunctionFWrapper() -> FunctionFW<T, R>
}

/// Represents a wrapper for a FunctionF.
public protocol FunctionFWrapperType: FunctionFWrapperConvertibleType {
  var ff: FunctionF<T, R> { get }

  #if DEBUG
  var description: String { get }

  init(_ ff: @escaping FunctionF<T, R>, _ description: String)
  #endif

  init(_ ff: @escaping FunctionF<T, R>)
}

public extension FunctionFWrapperType {

  /// Convenience method to wrap a Function and create another Function.
  ///
  /// - Parameter f: A Function instance.
  /// - Returns: A FunctionW instance.
  public func wrap(_ f: @escaping Function<T, R>) -> FunctionW<T, R> {
    return FunctionW(ff(f))
  }

  /// Compose with another FunctionF to form a new FunctionFW.
  ///
  /// - Parameter ff: A FunctionF instance.
  /// - Returns: A Self instance.
  public func compose(_ ff: @escaping FunctionF<T, R>) -> Self {
    return Self({self.wrap(ff($0)).f})
  }

  /// Compose with another FunctionFW to form a new FunctionFW.
  ///
  /// - Parameter ffw: A FunctionFW instance.
  /// - Returns: A Self instance.
  public func compose<FFW>(_ ffw: FFW) -> Self where
    FFW: FunctionFWrapperConvertibleType, FFW.T == T, FFW.R == R
  {
    let ffWrapper = ffw.asFunctionFWrapper()
    let ff = compose(ffWrapper.ff).ff

    #if DEBUG
    let description = appendDescription(ffWrapper.description)
    return Self(ff, description)
    #else
    return Self(ff)
    #endif
  }
}

#if DEBUG
extension FunctionFWrapperType {
  func appendDescription(_ description: String) -> String {
    return "\(self.description) - \(description)"
  }
}
#endif
