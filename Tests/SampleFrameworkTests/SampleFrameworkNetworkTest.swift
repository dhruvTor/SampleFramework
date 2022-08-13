//
//  SampleFrameworkNetworkTest.swift
//  SampleFrameworkTests
//
//  Created by Dhruv Jaiswal on 05/08/22.
//

import XCTest
@testable import SampleFramework

class NetworkSessionMock:NetworkSession{
    
    var data:Data?
    var error:Error?
    
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(data,error)
    }
    func post(with request:URLRequest,completionHandler:@escaping (Data?,Error?) -> Void){
        completionHandler(data,error)
    }
    
    
}

struct MockData:Codable,Equatable{
    var id:Int
    var name:String
}

final class SampleFrameworkNetworkTest: XCTestCase {

    func testLoadCallData() {
        let manager = SampleFramework.Networking.Manager()
        let session = NetworkSessionMock()
        manager.session = session
        let exp = XCTestExpectation(description: "called for data")
        let data = Data([0,1,0,1])
        session.data = data
        let url = URL(fileURLWithPath: "url")
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
    
    func testSendDataCall(){
        let session = NetworkSessionMock()
        let manager = SampleFramework.Networking.Manager()
        let sampleObject = MockData(id: 1, name: "Dhruv")
        let data = try? JSONEncoder().encode(sampleObject)
        session.data = data
        manager.session = session
        let url = URL(fileURLWithPath: "url")
        let exp = XCTestExpectation(description: "Send Data")
        manager.sendData(to:url,body:sampleObject){ result in
            exp.fulfill()
            switch result{
            case .success(let returnedData):
                let returnedObject = try? JSONDecoder().decode(MockData.self, from: returnedData)
                XCTAssertEqual(returnedObject, sampleObject)
                break
            case .failure(let error):
                XCTFail(error?.localizedDescription ?? "error")
            }
        }
        wait(for: [exp], timeout: 5)
        
    }


}
