//
//  CellDataModel.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/07/17.
//

//
//  CellDataModel.swift
//  ExpandableTableViewCells
//
//  Created by Artsiom Khaliliayeu on 25.02.23.
//

import Foundation

struct CellDataModel {
    let title: String
    let description: String
    var isExpanded = false

    static var mockedData: [CellDataModel] = [
        CellDataModel(title: "내 계좌확인", description: "index"),
        CellDataModel(title: "도움말", description: "트레이닝 서비스는 AI 모델을 보유한 주식을 소유하고 있을 때 가능합니다."),
        CellDataModel(title: "약관확인", description: "투자에 대한 책임은 본인에게 있습니다."),
        CellDataModel(title: "로그아웃", description: ""),
    ]
}


