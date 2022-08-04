//
//  SampleFrameworkNetworkTest.swift
//  SampleFrameworkTests
//
//  Created by Dhruv Jaiswal on 05/08/22.
//

import XCTest
@testable import SampleFramework

final class SampleFrameworkNetworkTest: XCTestCase {

    func testLoadCallData() {
        let manager = SampleFramework.Networking.Manager()
        let exp = XCTestExpectation(description: "called for data")
        guard let url = URL(string: "https://raywenderlich.com") else{
            return XCTFail("Could not create url properly")
        }
        manager.loadData(from:url){ result in
            exp.fulfill()
            switch result{
            case .success(let returnedData):
                XCTAssertNotNil(returnedData)
            case .failure(let error):
                XCTFail(error?.localizedDescription ?? "error")
            }
        }
        wait(for: [exp], timeout: 5)
    }


}
