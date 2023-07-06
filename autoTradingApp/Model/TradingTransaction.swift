//
//  TradingData.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/07/05.
//

import Foundation

//by Group
class TradingTransaction: Hashable {
    let cells: [String]
    let identifier: String

    init(
        cells: [String],
        identifier: String = UUID().uuidString
    ) {
        self.cells = cells
        self.identifier = identifier
    }
}

extension TradingTransaction {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: TradingTransaction, rhs: TradingTransaction) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    static let all = [
        TradingTransaction(cells: ["1", "2", "3", "4", "5"]),
        TradingTransaction(cells: ["1-1", "2-1", "3-1", "4-1", "5-1"]),
        TradingTransaction(cells: ["1-2", "2-2", "3-2", "4-2", "5-2"]),
        TradingTransaction(cells: ["1-2", "2-2", "3-2", "4-2", "5-2"]),
        TradingTransaction(cells: ["1-2", "2-2", "3-2", "4-2", "5-2"]),
        TradingTransaction(cells: ["1-2", "2-2", "3-2", "4-2", "5-2"]),
        TradingTransaction(cells: ["1-2", "2-2", "3-2", "4-2", "5-2"]),
        TradingTransaction(cells: ["1-2", "2-2", "3-2", "4-2", "5-2"]),
        TradingTransaction(cells: ["1-2", "2-2", "3-2", "4-2", "5-2"]),
        TradingTransaction(cells: ["1-2", "2-2", "3-2", "4-2", "5-2"]),
    ]
}

//by Rows
//struct TradingData {
//    let count: Int
//    let transactions: [TradingTransaction]
//
//}
