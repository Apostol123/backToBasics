

import Foundation
public protocol NetworkService {
    func get(url: URL, completion: @escaping(Data?, URLResponse?, Error?) -> Void)
}

class NetworkServiceImpl: NetworkService {
    let session: URLSessionadada
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            completion(data, response, error)
        })
        task.resume()
    }
}
