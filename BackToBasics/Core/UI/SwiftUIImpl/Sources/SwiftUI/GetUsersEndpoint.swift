//
//  File.swift
//  
//
//  Created by Alex.personal on 14/2/24.
//

import Foundation
import URLRequestFactory
public enum GetUserEndpoints {
    case get
    
    func urlRequest() -> URLRequest {
        switch self {
        case .get:
            let urlRequest = URLRequestFactory().makeRequest(
                with: URLRequestFactory.URLRequestFactoryComponenet(
                    scheme: "https",
                    host: "dummyjson.com",
                    path: "/users"
                )
            )
            return urlRequest
        }
    }
}
