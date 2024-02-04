import XCTest
@testable import URLRequestFactory

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
