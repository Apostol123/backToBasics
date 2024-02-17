//
//  File.swift
//  
//
//  Created by Alex.personal on 13/2/24.
//

import Foundation
import NetworkServiceAbstractionLayer
import Combine



public class SwiftUIViewModel: ObservableObject {
    private let service: NetworkServiceAbstractionLayerProtocol
    private var cancellable: AnyCancellable?
    @Published private(set) var listItems: [SwiftUIImplDataModel] = []
    
    public init(service: NetworkServiceAbstractionLayerProtocol) {
        self.service = service
    }
    
    func getDataCombine() -> AnyPublisher<[SwiftUIImplDataModel], Error>{
        let subject = PassthroughSubject<[SwiftUIImplDataModel], Error>()
        service.execute(request: GetUserEndpoints.get.urlRequest(), type: Users.self) { result in
            switch result {
            case .success(let success):
                subject.send(SwiftUIViewModel.map(success))
                subject.send(completion: .finished)
            case .failure(let failure):
                subject.send(completion: .failure(failure))
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    func viewDidAppear() {
        cancellable = getDataCombine().receive(on: DispatchQueue.main).sink(receiveCompletion: { _ in
            
        }, receiveValue: { models in
            self.listItems = models
        })
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
