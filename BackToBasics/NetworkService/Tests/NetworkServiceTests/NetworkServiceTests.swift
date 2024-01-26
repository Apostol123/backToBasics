import XCTest
@testable import NetworkService

final class NetworkServiceTests: XCTestCase {
    
    func test_getFromURLPerformsGetRequestWithURL() throws {
        let sut = makeSut()
        let url = anyURL()
        
        let exp = expectation(description: "wait for request")
        URLProtocolStub.observeRequests { request in
            XCTAssertEqual(request.url, url)
            XCTAssertEqual(request.httpMethod, "GET")
            exp.fulfill()
        }
        
        sut.get(url: url, completion: {_, _, _ in})
        wait(for: [exp], timeout: 1.0)
    }
    
    //MARK: Helpers
    
    private func makeSut() -> NetworkService {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        
        let sut = NetworkServiceImpl(session: session)
        return sut
    }
    
    private func anyURL() -> URL {
        URL(string: "www.google.com")!
    }
}
