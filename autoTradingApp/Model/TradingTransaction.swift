//
//  TradingData.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/07/05.
//

import Foundation

//by Group
struct TradingTransaction {
    let name: String
    let code: String
    let date: String
    let price: Double
    let action: String
    let count: Int
    let investment: Double

    static let all = [TradingTransaction(name: "s", code: "1", date: "2023.06.29", price: 123, action: "buy", count: 5, investment: 11),
                      TradingTransaction(name: "s1", code: "1", date: "2023.06.29", price: 123, action: "buy", count: 6, investment: 11),
                      TradingTransaction(name: "s2", code: "1", date: "2023.06.29", price: 123, action: "buy", count: 7, investment: 11),
                      TradingTransaction(name: "s3", code: "1", date: "2023.06.29", price: 123, action: "buy", count: 8, investment: 11),]
}
