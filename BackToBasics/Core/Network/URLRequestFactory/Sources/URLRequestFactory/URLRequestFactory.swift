import Foundation

public final class URLRequestFactory {
    public struct URLRequestFactoryComponenet {
        let scheme: String
        let host: String
        let path: String
        let queryItems: [URLQueryItem]?
        
        public init(scheme: String, host: String, path: String, queryItems: [URLQueryItem]? = nil) {
            self.scheme = scheme
            self.host = host
            self.path = path
            self.queryItems = queryItems
        }
    }
    
    public init() {}
    
    public func makeRequest(with factoryComponenet: URLRequestFactoryComponenet) -> URLRequest {
        var component = URLComponents()
        component.host = factoryComponenet.host
        component.scheme = factoryComponenet.scheme
        component.path = factoryComponenet.path
        component.queryItems = factoryComponenet.queryItems
        let url = component.url!
        return URLRequest(url: url)
    }
}
