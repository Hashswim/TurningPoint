//
//  Stock.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/03/08.
//

import Foundation

struct Stock: Hashable {
    let name: String
    var price: Double

    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }

    private let identifier = UUID()

    static let all = [
        Stock(name: "AAPL", price: 111.00),
        Stock(name: "삼성전자", price: 100000.00),
        Stock(name: "alphabet", price: 123.12)
    ]

}
