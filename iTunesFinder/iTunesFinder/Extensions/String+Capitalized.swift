//
//  String+Capitalized.swift
//  Regula_iTunesApp
//
//  Created by Aliaksei Gorodji on 30.05.22.
//

import Foundation

extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
}
