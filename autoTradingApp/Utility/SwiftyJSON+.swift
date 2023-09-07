//
//  SwiftyJSON+.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/09/07.
//

import Foundation

import SwiftyJSON
extension JSON {
    func toString() -> String? {
        return self.rawString()?.replacingOccurrences(of: "\"", with: "", options: String.CompareOptions.regularExpression, range: nil)
    }
}
