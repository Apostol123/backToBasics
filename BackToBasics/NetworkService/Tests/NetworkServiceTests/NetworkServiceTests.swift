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
        
        sut.execute(url: url, completion: {_, _ in})
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_sut_given_error_completesWithError() {
        let sut = makeSut()
        let url = anyURL()
        let givenError = anyError()
        
        URLProtocolStub.stub(data: nil, response: nil, error: givenError)
        let exp = expectation(description: "wait for request")
        
        sut.execute(url: url, completion: {result, _ in
            switch result {
            case .success(let success):
                XCTFail("expected \(givenError) but con \(success) instead")
            case .failure:
                break
            }
            
            exp.fulfill()
        })
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
    
    private func anyError() -> NSError {
       NSError(domain: "any error", code: 0)
    }
}
