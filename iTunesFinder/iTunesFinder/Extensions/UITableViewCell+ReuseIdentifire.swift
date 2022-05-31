//
//  UITableViewCell+ReuseIdentifire.swift
//  Regula_iTunesApp
//
//  Created by Aliaksei Gorodji on 30.05.22.
//

import UIKit

extension UITableViewCell {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
