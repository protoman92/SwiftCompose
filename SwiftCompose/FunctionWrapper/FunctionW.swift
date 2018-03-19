//
//  FunctionW.swift
//  SwiftCompose
//
//  Created by Hai Pham on 18/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

/// Wrapper for Function.
///
/// The catch of this function wrapper is that similar to a subscription in rx,
/// input flows up from the bottom composed function. Therefore, the ordering
/// of the operators may be different from how one would do in rx.
///
/// For e.g., we want to filter out even integers and take only distinct values.
/// In rx we would do something like:
///
///   intObservable
///     .filter({$0 % 2 != 0})
///     .distinctUntilChanged()
///     .subscribe()
///     .disposed(by: disposeBag)
///
/// We would expect filter to be called first, then distinctUntilChanged. This
/// is because events flow from top to bottom. Whereas using a CallbackW, which
/// is a specialized form of FunctionW:
///
///    CallbackW(intCallback)
///     .filter({$0 % 2 != 0})
///     .distinctUntilChanged()
///     .invoke(1)
///
/// The distinctUntilChanged operator is actually called first to filter out
/// duplicate inputs, after which it feeds the result to filter, and finally
/// to the wrapped callback.
public struct FunctionW<T, R> {
  public let function: Function<T, R>

  #if DEBUG
    public let description: String

    public init(_ f: @escaping Function<T, R>, _ description: String) {
      self.function = f
      self.description = description
    }
  #endif

  public init(_ f: @escaping Function<T, R>) {
    self.function = f

    #if DEBUG
      description = String(describing: FunctionW.self)
    #endif
  }
}

extension FunctionW: FunctionWrapperConvertibleType {
  public func asFunctionWrapper() -> FunctionW<T, R> {
    return self
  }
}

extension FunctionW: FunctionWrapperType {}

#if DEBUG
  extension FunctionW: CustomStringConvertible {}
#endif
