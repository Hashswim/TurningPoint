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
}

//by Rows
class TradingData: Hashable {
//    let count: Int
    let identifier: String
    let transactions: [TradingTransaction]

    init(
        cells: [TradingTransaction],
        identifier: String = UUID().uuidString
    ) {
        self.transactions = [
            TradingTransaction(cells: ["1", "2", "3", "4", "5"]),
            TradingTransaction(cells: ["1-1", "2-1", "3-1", "4-1", "5-1"]),
            TradingTransaction(cells: ["1-3", "2-2", "3-2", "4-2", "5-2"]),
            TradingTransaction(cells: ["1-4", "2-2", "3-2", "4-2", "5-2"]),
            TradingTransaction(cells: ["1-5", "2-2", "3-2", "4-2", "5-2"]),

            TradingTransaction(cells: ["1-6", "2-2", "3-2", "4-2", "5-2"]),
            TradingTransaction(cells: ["1-7", "2-2", "3-2", "4-2", "5-2"]),
            TradingTransaction(cells: ["1-8", "2-2", "3-2", "4-2", "5-2"]),
            TradingTransaction(cells: ["1-9", "2-2", "3-2", "4-2", "5-2"]),
            TradingTransaction(cells: ["1-10", "2-2", "3-2", "4-2", "5-2"]),
        ].compactMap({$0})

        self.identifier = identifier
    }
}

extension TradingData {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: TradingData, rhs: TradingData) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
