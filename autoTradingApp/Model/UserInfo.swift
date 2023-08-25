//
//  AccessToken.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/08/10.
//

import Foundation

class UserInfo {
    static let shared = UserInfo()

    var name: String?
    var accessToken: String?
    var favoriteList: [String: Bool]? = [String: Bool]()

    private init() {}
}
