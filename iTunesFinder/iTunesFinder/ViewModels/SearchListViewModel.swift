//
//  SearchListViewModel.swift
//  iTunesFinder
//
//  Created by Aliaksei Gorodji on 27.05.22.
//

import Foundation

class SearchListViewModel <S: Session> {
    
    typealias DefaultCallback = (([Item]) -> Void)
    
    private var service: iTunesService<S>
    var searchedItems = [Item]()
    var dataHasBeenUpdated: DefaultCallback?
    
    init(session: S) {
        self.service = iTunesService(session: session)
    }
    
    func search(_ term: String, type: MediaType) {
        service.searchContentFor(term, type: type) { [weak self] result in
            switch result {
            case .success(let items):
                self?.searchedItems = items
                self?.dataHasBeenUpdated?(items)
            case .failure(let error):
                self?.searchedItems = []
                self?.dataHasBeenUpdated?([])
                debugPrint("🔴 \(error.localizedDescription)")
            }
        }
    }
    
}
