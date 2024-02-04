import XCTest
import Stubs
@testable import NetworkServiceAbstractionLayer

final class NetworkServiceAbstractionLayerTests: XCTestCase {
    
    func test_get_with_correctData_resturns_expected_decoded_value() throws {
        let mockData = try makeData()
        let mockStruct = makeMockStruct()
        let sut = makeSut()
        let request = URLRequest(url: URL(string: "www.google.con")!)
        
        URLProtocolStub.stub(data: mockData, response: nil, error: nil)
       

        sut.execute(request: request, type: MyMockStruct.self) { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(success, mockStruct)
            case .failure(let failure):
                XCTFail("Expected success but got \(failure) instead")
            }
        }
    }
    
    // MARK: Helpers
    
    func makeSut() -> NetworkServiceAbstractionLayer {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        return NetworkServiceAbstractionLayer(session: session)
    }
    
    private struct MyMockStruct: Codable, Equatable {
        let name: String
    }
    
    private func makeMockStruct() -> MyMockStruct {
        MyMockStruct(name: "testName")
    }
    
    private func makeData() throws -> Data {
        let myMockStruct = makeMockStruct()
        return try JSONEncoder().encode(myMockStruct)
    }
}
