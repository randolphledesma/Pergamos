import Routing
import Vapor
import Crypto
import Leaf
import Jobs

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
        DispatchQueue.global(qos: .background).async {
            /// Puts the background thread to sleep
            /// This will not affect any of the event loops
            sleep(5)

            /// When the "blocking work" has completed,
            /// complete the promise and its associated future.
            promise.succeed(result: "Hello, world!")
        }

        /// Wait for the future to be completed,
        return promise.futureResult
    }

    // Example of creating a Service and using it.
    router.get("run") { req -> String in
        let uuid = UUID().uuidString
        Jobs.oneoff(delay: 10.seconds) {
            print("I was delayed by 10 seconds. \(uuid)")
        }
        return uuid
    }

    router.get("run2") { req -> String in
        let uuid = UUID().uuidString.lowercased()
        let promise = req.eventLoop.newPromise(Void.self)
        promise.futureResult.do {
            print("done")
        }.catch { error in
            print("error")
        }.always {
            print("always")
        }
        DispatchQueue.global(qos: .utility).async {
            let sessionConfig = URLSessionConfiguration.default
            sessionConfig.timeoutIntervalForRequest = TimeInterval(10)
            //sessionConfig.timeoutIntervalForResource = 5.0
            sessionConfig.httpAdditionalHeaders = ["User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_3"]
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            let urlComponents = NSURLComponents(string: "https://httpbin.org/anything")!
            urlComponents.queryItems = [
                URLQueryItem(name: "param", value: "this is a parameter"),
                URLQueryItem(name: "args", value: "with special %&?/~!@#$%^&*()"),
                URLQueryItem(name: "uuid", value: uuid)
            ]
            var request = URLRequest(url: urlComponents.url!)
            request.httpMethod = "GET"
            let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if (error == nil) {
                    if let newdata = data, let str = String(data: newdata, encoding: .utf8) {
                        print(str)
                    }
                    promise.succeed()
                } else {
                    promise.fail(error: error!)
                }
            })
            task.resume()
        }
        return uuid
    }

    // Example of creating a Service and using it.
    router.get("hash", String.parameter) { req -> String in
        let string = try req.parameters.next(String.self)
        let digest = try BCrypt.hash(string, cost: 6)

        return digest
    }

    router.get("welcome") { req -> Future<View> in
        return try req.view().render("welcome")
    }

    router.get("person") { req -> Future<View> in
        let developer = Person(name: "Randolph", greeting: "Nice to meet you.")
        return try req.view().render("person", developer)
    }

    router.get("team") { req -> Future<View> in
        let leaf = try req.make(LeafRenderer.self)
        let context = ["team": ["James", "Peter", "John"]]
        return leaf.render("team", context)
    }
}