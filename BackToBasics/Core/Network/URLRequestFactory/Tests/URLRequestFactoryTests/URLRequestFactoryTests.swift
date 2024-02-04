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
    func test_urlRequestFactory_createsURL_fromGivenParams() throws {
        //given
        let sut = makeSUT()
        let mockURL = URL(string: "https://dummyjson.com/users?limit=5")!
        let factoryComponent = URLRequestFactory.URLRequestFactoryComponenet(
            scheme: "https",
            host:"dummyjson.com" ,
            path: "/users",
            queryItems: [
                URLQueryItem(name: "limit", value: "5")
            ]
        )
        //when
        //then
        XCTAssertEqual(sut.makeRequest(with: factoryComponent).url?.absoluteURL, mockURL.absoluteURL)
    }
    
    private func makeSUT() -> URLRequestFactory {
        return URLRequestFactory()
    }
}
