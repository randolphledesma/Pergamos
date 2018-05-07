import App
import Dispatch
import XCTest
import Crypto

final class AppTests: XCTestCase {
    func testBCrypt() throws {
        let hash = try BCrypt.hash("randolph", cost: 6)
        let verify = try BCrypt.verify("randolph", created: hash)
        XCTAssert(verify)
    }

    static let allTests = [
        ("testBCrypt", testBCrypt)
    ]
}
