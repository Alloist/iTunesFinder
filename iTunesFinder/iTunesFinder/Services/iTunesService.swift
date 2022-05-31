//
//  iTunesService.swift
//  iTunesFinder
//
//  Created by Aliaksei Gorodji on 27.05.22.
//

import UIKit


enum MediaType: String, CaseIterable {
    case music
    case software
    case ebook
}

enum iTunesSearchApiError:Error{
    case error(Error)
    case jsonParsing(String)
    case customError(String)
}


final class iTunesService <S: Session> {
        
    private var searchItems: [Item] = []
    private let client: NetworkClient<S>
    
    private let maxLimitOfSearch = "25"
    
    init(session: S) {
        self.client = NetworkClient(session: session)
    }
     
    
    func searchContentFor(_ term: String, type: MediaType, completion:@escaping (Result<[Item], iTunesSearchApiError>)-> Void) {
        
        guard let validUrl = prepareUrl(term: term, type: type) else {
            fatalError("🔴 Url is not valid!")
        }
        
        client.searchContent(by: validUrl) { result in
            
            switch result {
                case .failure(let iTunesSearchApiError):
                    completion(.failure(iTunesSearchApiError))
                    
                case .success(let data):
                    if let errorString = self.getSearchItems(from: data) {
                        completion(.failure(iTunesSearchApiError.jsonParsing(errorString)))
                    } else {
                        completion(.success(self.searchItems))
                    }
            }
        }
        
    }
    
    private func prepareUrl(term: String, type: MediaType) -> URL? {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/search"
        
        
        let searchString = term.isEmpty ? "\"\"" : term
            
        components.queryItems = [
            URLQueryItem(name: "term", value: searchString),
            URLQueryItem(name: "media", value: type.rawValue),
            URLQueryItem(name: "limit", value: maxLimitOfSearch)
        ]
        
        debugPrint("🟢 \(components.url?.absoluteString ?? "url?")")
        
        return components.url
    }
    
    private func getSearchItems(from data: Data) -> String? {
        let decoder = JSONDecoder()
        
        do {
            let searchApiResponse = try decoder.decode(APIResponse.self, from: data)
            self.searchItems = searchApiResponse.results
        } catch {
            searchItems = []
            return error.localizedDescription
        }
        return nil
    }

}
