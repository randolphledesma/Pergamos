import Routing
import Vapor
import Crypto

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    //Non-blocking "Hello, world!" example
    router.get("helloworld") { req -> Future<String> in
        /// Create a new void promise
        let promise = req.eventLoop.newPromise(String.self)

        /// Dispatch some work to happen on a background thread
        DispatchQueue.global(qos: .background).async(execute: {
            /// Puts the background thread to sleep
            /// This will not affect any of the event loops
            sleep(5)

            /// When the "blocking work" has completed,
            /// complete the promise and its associated future.
            promise.succeed(result: "Hello, world!")
        })

        /// Wait for the future to be completed,
        return promise.futureResult
    }

    // Example of creating a Service and using it.
    router.get("hash", String.parameter) { req -> String in
        let string = try req.parameters.next(String.self)
        let digest = try BCrypt.hash(string, cost: 6)

        return digest
    }
}
