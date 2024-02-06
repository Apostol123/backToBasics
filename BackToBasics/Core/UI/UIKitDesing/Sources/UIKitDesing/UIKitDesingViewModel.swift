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
}

public final class UIKitDesignViewModel: UIKitDesignViewModelProtocol {
    private let service: NetworkServiceAbstractionLayerProtocol
    
    init(service: NetworkServiceAbstractionLayerProtocol) {
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
    
    // Mapper
    static func map(_ users: Users) -> [UIKitDesingImplDataModel] {
       return users.users.map { user in
           UIKitDesingImplDataModel(name: user.maidenName, surname: user.firstName, imageURL: user.image)
       }.compactMap({$0})
       
    }
}
