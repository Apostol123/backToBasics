

import Foundation
public protocol NetworkService {
    func get(url: URL, completion: @escaping(Result<Data, Error>, URLResponse?) -> Void)
}

class NetworkServiceImpl: NetworkService {
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get(url: URL, completion: @escaping(Result<Data, Error>, URLResponse?) -> Void) {
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error {
                completion(.failure(error), response)
            }
            if let data = data {
                completion(.success(data), response)
            }
        })
        task.resume()
    }
}
