import Foundation
import NetworkService

public protocol NetworkServiceAbstractionLayerProtocol {
    func execute<T: Decodable>(request: URLRequest, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

public final class NetworkServiceAbstractionLayer: NetworkServiceAbstractionLayerProtocol {
    private let service: NetworkServiceImpl
    
    public init(session: URLSession) {
        service = NetworkServiceImpl(session: session)
    }
    
    public func execute<T: Decodable>(request: URLRequest, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
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
                    completion(.failure(error))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}

private enum NetworkServiceAbstractionLayerError: Error {
    case requestHasNoURL
}
