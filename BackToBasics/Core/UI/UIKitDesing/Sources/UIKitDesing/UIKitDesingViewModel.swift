//
//  File.swift
//  
//
//  Created by Alex.personal on 6/2/24.
//

import Foundation
import NetworkServiceAbstractionLayer

public protocol UIKitDesignViewModelProtocol {
    func getData(completion: @escaping (Result<[UIKitDesingImplDataModel], Error>) -> Void)
    func loadImage(for url: String, completion: @escaping (Result<Data, Error>) -> Void)
}

public final class UIKitDesignViewModel: UIKitDesignViewModelProtocol {
    private let service: NetworkServiceAbstractionLayerProtocol
    
    public init(service: NetworkServiceAbstractionLayerProtocol) {
        self.service = service
    }
    
    public func getData(completion: @escaping (Result<[UIKitDesingImplDataModel], Error>) -> Void) {
        service.execute(request: GetUserEndpoints.get.urlRequest(), type: Users.self) { result in
            switch result {
            case .success(let success):
                completion(.success(UIKitDesignViewModel.map(success)))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    public func loadImage(for url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        let urlRequest = URLRequest(url: url)
        service.execute(request: urlRequest, type: Data.self) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    // Mapper
    static func map(_ users: Users) -> [UIKitDesingImplDataModel] {
       return users.users.map { user in
           UIKitDesingImplDataModel(name: user.maidenName, surname: user.firstName, imageURL: user.image)
       }.compactMap({$0})
       
    }
}
