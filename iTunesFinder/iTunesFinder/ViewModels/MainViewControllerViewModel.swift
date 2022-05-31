//
//  MainViewControllerViewModel.swift
//  iTunesFinder
//
//  Created by Aliaksei Gorodji on 30.05.22.
//

import Foundation
import UIKit

class MainViewControllerViewModel {
    
    typealias DefaultCallback = (() -> Void)
    
//MARK: - Properties
    private let searchListViewModel = SearchListViewModel(session: URLSession.shared)
    private var lastSearched = String()
    var searchedItems = [Item]()
    var savedItems = [Item]()
    
    var imageCache = NSCache<NSString, UIImage>()
    
    private var selectedMediaType: MediaType {
        didSet {
            searchListViewModel.search(lastSearched, type: selectedMediaType)
        }
    }
    
 //MARK: - Callbacks
    var dataHasBeenUpdated: DefaultCallback?
    
//MARK: - Init
    init() {
        self.selectedMediaType = .music
        self.bind()
    }
    
//MARK: - Publick methods
    func setMediaType(index: Int) {
        let values = MediaType.allCases
        selectedMediaType = values[index]
    }
    
    
    func search(_ term: String) {
        lastSearched = term
        searchListViewModel.search(term, type: selectedMediaType)
    }
    
}

//MARK: - Private methods
private extension MainViewControllerViewModel {
    func bind() {
        self.bindSeasrchListViewModel()
    }
    
    func bindSeasrchListViewModel() {
        searchListViewModel.dataHasBeenUpdated = { [weak self] items in
            self?.searchedItems = items
            self?.dataHasBeenUpdated?()
        }
    }
}
