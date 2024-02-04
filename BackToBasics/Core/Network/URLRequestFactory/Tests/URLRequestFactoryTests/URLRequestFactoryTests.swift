import XCTest
@testable import URLRequestFactory

public final class URLRequestFactory {
    public struct URLRequestFactoryComponenet {
        let scheme: String
        let host: String
        let path: String
        let queryItems: [URLQueryItem]?
    }
    
    func makeRequest(with factoryComponenet: URLRequestFactoryComponenet) -> URLRequest {
        var component = URLComponents()
        component.host = factoryComponenet.host
        component.scheme = factoryComponenet.scheme
        component.path = factoryComponenet.path
        component.queryItems = factoryComponenet.queryItems
        let url = component.url!
        return URLRequest(url: url)
    }
}

final class URLRequestFactoryTests: XCTestCase {
    func testExample() throws {
        //given
        let sut = makeSUT()
        let mockURL = URL(string: "https://dummyjson.com")!
        let factoryComponent = URLRequestFactory.URLRequestFactoryComponenet(scheme: "https", host:"dummyjson.com" , path: "", queryItems: nil)
        //when
        //then
        XCTAssertEqual(sut.makeRequest(with: factoryComponent).url?.absoluteURL, mockURL.absoluteURL)
    }
    
    private func makeSUT() -> URLRequestFactory {
        return URLRequestFactory()
    }
}