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

    // Example of creating a Service and using it.
    router.get("hash", String.parameter) { req -> String in
        let string = try req.parameters.next(String.self)
        let digest = try BCrypt.hash(string, cost: 6)

        return digest
    }
}
