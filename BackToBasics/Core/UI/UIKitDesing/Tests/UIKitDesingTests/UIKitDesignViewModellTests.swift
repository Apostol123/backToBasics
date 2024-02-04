//
//  UIKitDesignViewModellTests.swift
//  
//
//  Created by Alex.personal on 1/2/24.
//

import XCTest
import URLRequestFactory
@testable import UIKitDesing
import NetworkServiceAbstractionLayer

public protocol UIKitDesignViewModelProtocol {
    func getData(completion: @escaping (Result<[UIKitDesingImplDataModel], Error>) -> Void)
}

final class UIKitDesignViewModellTests: XCTestCase {
    
    func test_viewModel_onGetDataRequest_withSucces_Expecte_sucessReturn() throws {
       
        //when
        completeGetData(with: .success(UIKitDesignViewModellTests.makeModels()))
        
    }
    
    func test_viewModel_onGetDataRequest_withError_Expecte_ErrorReturn() throws {
       
        //when
        completeGetData(with: .failure(anyError()))
        
    }
    
    private func completeGetData(with giveResult:  Result<[UIKitDesingImplDataModel],Error>) {
        let sut = UIKitDesignViewModel(service: <#NetworkServiceAbstractionLayerProtocol#>)
        let exp = expectation(description: "Wait for load completion")
        sut.getData { result in
            switch (giveResult, result) {
            case let (.success(givenModels), .success(expectedModels)):
                XCTAssertEqual(givenModels, expectedModels)
            
            case let (.failure(recievedError), .failure(expectedError)):
                XCTAssertEqual(recievedError as NSError, expectedError as NSError)

            default:
                XCTFail("Expected \(giveResult) got \(result) instead")
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    private class UIKitDesignViewModel: UIKitDesignViewModelProtocol {
        private let service: NetworkServiceAbstractionLayerProtocol
        
        init(service: NetworkServiceAbstractionLayerProtocol) {
            self.service = service
        }
        
        func getData(completion: @escaping (Result<[UIKitDesingImplDataModel], Error>) -> Void) {
            service.execute(request: GetUserEndpoints.get.urlRequest(), type: Users.self) { result in
                switch result {
                case .success(let success):
                    completion(.success([]))
                case .failure(let failure):
                    completion(.failure(failure))
                }
            }
        }
    }
    
    
    enum GetUserEndpoints {
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
    
    private func anyError() -> NSError {
        return NSError(domain: "www.anydomin.com", code: 0)
    }
}


