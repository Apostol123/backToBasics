//
//  File.swift
//  
//
//  Created by Alex.personal on 13/2/24.
//

import Foundation
import NetworkServiceAbstractionLayer

public struct SwiftUIViewModel {
    private let service: NetworkServiceAbstractionLayerProtocol
    
    public init(service: NetworkServiceAbstractionLayerProtocol) {
        self.service = service
    }
    
    public func getData(completion: @escaping (Result<[SwiftUIImplDataModel], Error>) -> Void) {
        service.execute(request: GetUserEndpoints.get.urlRequest(), type: Users.self) { result in
            switch result {
            case .success(let success):
                completion(.success(SwiftUIViewModel.map(success)))
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
    
    static func map(_ users: Users) -> [SwiftUIImplDataModel] {
       return users.users.map { user in
           SwiftUIImplDataModel(name: user.maidenName, surname: user.firstName, imageURL: user.image)
       }.compactMap({$0})
       
    }
}
