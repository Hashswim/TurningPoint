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

    static var all: [TradingTransaction] = []
}
