import XCTest
@testable import URLRequestFactory

public final class URLRequestFactory {
    func makeRequest(with url: URL) -> URLRequest {
        URLRequest(url: url)
    }
}

final class URLRequestFactoryTests: XCTestCase {
    func testExample() throws {
        //given
        let sut = makeSUT()
        let mockURL = URL(string: "https://dummyjson.com")!
        //when
        //then
        XCTAssertEqual(sut.makeRequest(with: mockURL).url?.absoluteURL, mockURL.absoluteURL)
    }
    
    private func makeSUT() -> URLRequestFactory {
        return URLRequestFactory()
    }
}
