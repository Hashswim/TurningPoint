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
    var appKey: String?
    var accessToken: String?
    var favoriteList: [String]?
    var trainingList: [String]?

    private init() {}
}

struct UserAccount {
    static var shared = UserAccount()

    var sunamt: Double?        //추정순자산
    var dtsunik: Double?       //실현손익
    var mamt: Double?          //매입금액
    var sunamt1: Double?       //추정D2예수금
    var tappamt: Double?       //평가금액
    var tdtsunik: Double?      //평가손익

    private init() {}
}
