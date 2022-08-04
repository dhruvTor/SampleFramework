import XCTest
@testable import SampleFramework

final class SampleFrameworkColorTests: XCTestCase {
    
    func testColorRedEqual(){
        let color = SampleFramework.Color.fromHexString("FF0000")
        XCTAssertEqual(color, .red)
    }
    
    func testColorAreEqual(){
        let color = SampleFramework.Color.fromHexString("006736")
        XCTAssertEqual(color, SampleFramework.Color.sampleColor)
    }
    
    func testSecondaryColorAreEqual(){
        let color = SampleFramework.Color.fromHexString("FCFFFD")
        XCTAssertEqual(color, SampleFramework.Color.secondaryColor)
    }
}
