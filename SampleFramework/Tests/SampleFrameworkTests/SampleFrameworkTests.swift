import XCTest
@testable import SampleFramework

final class SampleFrameworkTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SampleFramework().text, "Hello, World!")
    }
}
