//
//  Session.swift
//  iTunesFinder
//
//  Created by Aliaksei Gorodji on 27.05.22.
//

import Foundation

protocol Session {
    
    associatedtype Task: DataTask
    
    func dataTask(with url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Task
}


protocol DataTask {
    func resume()
}


extension URLSession: Session {
    
}

extension URLSessionDataTask: DataTask {
    
}
