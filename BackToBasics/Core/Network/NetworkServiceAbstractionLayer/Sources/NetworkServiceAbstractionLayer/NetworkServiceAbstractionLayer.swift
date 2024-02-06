import Foundation
import NetworkService

public protocol NetworkServiceAbstractionLayerProtocol {
    func execute<T: Decodable>(request: URLRequest, type: T.Type, completion: @escaping (Result<T, NetworkServiceAbstractionLayerError>) -> Void)
}

public final class NetworkServiceAbstractionLayer: NetworkServiceAbstractionLayerProtocol {
    private let service: NetworkServiceImpl
    
    
    
    public init(session: URLSession) {
        service = NetworkServiceImpl(session: session)
    }
    
    public func execute<T: Decodable>(request: URLRequest, type: T.Type, completion: @escaping (Result<T, NetworkServiceAbstractionLayerError>) -> Void) {
        guard let url = request.url else {
            completion(.failure(NetworkServiceAbstractionLayerError.requestHasNoURL))
            return
        }
        service.execute(url: url) { result, _ in
            switch result {
            case .success(let success):
                do {
                    let decodedData = try JSONDecoder().decode(type, from: success)
                    completion(.success(decodedData))
                } catch  {
                    completion(.failure(.decodingFailed))
                }
            case .failure(let failure):
                completion(.failure(.anyError(error: failure)))
            }
        }
    }
}

public enum NetworkServiceAbstractionLayerError: Error {
    case requestHasNoURL
    case decodingFailed
    case anyError(error: Error)
}
