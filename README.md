# SwiftCompose

[![Build Status](https://travis-ci.org/protoman92/SwiftCompose.svg?branch=master)](https://travis-ci.org/protoman92/SwiftCompose)
[![Coverage Status](https://coveralls.io/repos/github/protoman92/SwiftCompose/badge.svg?branch=master)](https://coveralls.io/github/protoman92/SwiftCompose?branch=master)

Composable functions for Swift. This library may help those who aren't exactly comfortable with functional paradigms (such as rx). Usage is simple:

```swift
  func someFunction() throws -> Int {
    throw Exception("Invalid")
  }

  func main() {
    let composed = Compose<Int>.publish({print($0)})
      .compose(Compose.publishError({print($0)}))
      .compose(Compose.retryWithDelay(10)(0.5))
      .compose(Compose.noop())

    /// Now we have a higher-order function that accepts a function as parameter
    /// and transform it into another that has the specified traits.
    ///
    /// The code below will be retried up to 10 times, with a delay between each
    /// two consecutive set of retries. We also publish the value/error.
    try? composed.invoke(someFunction)()
  }
```

The idea is that we can abstract away some common logic (e.g. w.r.t error handling) by passing around these higher-order functions (perhaps via a dependency provider) and use them to infuse normal functions with special capabilities. For e.g., in **Compose.publishError(_:)**, we may run some code that asynchronously logs the error to server, so using this approach we can apply the same treatment everywhere.
