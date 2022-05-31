//
//  NetworkClient.swift
//  iTunesFinder
//
//  Created by Aliaksei Gorodji on 27.05.22.
//

import Foundation

final class NetworkClient<S: Session> {
       
    private let session: S

    init(session: S) {
        self.session = session
    }
    
    private static func getData(url: URL,
                                completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func searchContent(by url: URL, completion: @escaping (Result<Data, iTunesSearchApiError>) -> Void ) {
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let dataValid = data, error == nil else {
                return completion(.failure(.error(error!)))
            }
            
            if let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode != 200 {
                return completion(.failure(.customError("statusCode: \(urlResponse.statusCode)")))
            }
            
            completion(.success(dataValid))
            
        }
        
        task.resume()
    }
        
}
