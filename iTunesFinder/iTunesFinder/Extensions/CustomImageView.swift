//
//  CustomImageView.swift
//  iTunesFinder
//
//  Created by Aliaksei Gorodji on 31.05.22.
//

import Foundation
import UIKit

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsing(urlString: String, with imageCache: NSCache<NSString, UIImage>) {
        
        imageUrlString = urlString
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: NSString(string: urlString)) {
            image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error  {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
 
            DispatchQueue.main.async {
                let imageCache = UIImage(data: data)
                if self.imageUrlString == urlString {
                    self.image = imageCache
                }
            }
        }.resume()
    }
}
