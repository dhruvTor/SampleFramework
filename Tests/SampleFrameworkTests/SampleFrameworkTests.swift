import XCTest
@testable import SampleFramework

final class SampleFrameworkTests: XCTestCase {
    
    func testColorRedEqual(){
        let color = SampleFramework.colorFromHexString("FF0000")
        XCTAssertEqual(color, .red)
    }
    
    func testColorAreEqual(){
        let color = SampleFramework.colorFromHexString("006736")
        XCTAssertEqual(color, SampleFramework.sampleColor)
    }
}
