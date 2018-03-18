# SwiftCompose

[![Build Status](https://travis-ci.org/protoman92/SwiftCompose.svg?branch=master)](https://travis-ci.org/protoman92/SwiftCompose)
[![Coverage Status](https://coveralls.io/repos/github/protoman92/SwiftCompose/badge.svg?branch=master)](https://coveralls.io/github/protoman92/SwiftCompose?branch=master)

Composable functions for Swift. This library may help those who aren't exactly comfortable with functional paradigms (such as rx). Usage is simple:

```swift
  func someFunction(_ a: Int) throws -> Int {
    throw Exception("Invalid")
  }

  func main() {
    let composed = FunctionW<Int, Int>(someFunction)
      .timeout(0.5)(DispatchQueue.global(.background))
      .retryWithDelay(10)(0.5)
      .map({$0 * 2})

    /// Now we have a higher-order function that accepts a function as parameter
    /// and transform it into another that has the specified traits.
    ///
    /// The code below will be retried up to 10 times, with a delay between
    /// each two consecutive set of retries.
    try? composed.invoke(0)
  }
```
