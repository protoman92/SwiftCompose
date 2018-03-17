//
//  StrongReference.swift
//  SwiftCompose
//
//  Created by Hai Pham on 17/3/18.
//  Copyright © 2018 Hai Pham. All rights reserved.
//

final class StrongReference<T> {
  final let value: T

  public init(_ value: T) {
    self.value = value
  }
}
