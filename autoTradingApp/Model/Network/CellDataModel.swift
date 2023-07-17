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

    static let mockedData: [CellDataModel] = [
        CellDataModel(title: "내 계좌확인", description: "View and edit your profile information, including your name, email address, phone number, and profile picture. You can also update your password and manage your account settings here."),
        CellDataModel(title: "도움말", description: "Choose which notifications you want to receive, including push notifications, email notifications, and in-app notifications. You can customize the type of notifications you receive for different events and actions in the app."),
        CellDataModel(title: "약관확인", description: "Manage your privacy settings, including who can see your profile information and what information is visible to others. You can also control your data sharing preferences and manage your account security settings."),
        CellDataModel(title: "로그아웃", description: ""),
    ]
}


