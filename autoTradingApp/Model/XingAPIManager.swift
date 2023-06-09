//
//  XingAPIManager.swift
//  autoTradingApp
//
//  Created by 이민형 on 2023/05/29.
//

// For Singletone design

import Foundation
import XingAPIMobile

class XingAPIManager {
    static let shared = XingAPIManager();
    
    let xingAPI = XingAPI.getInstance();
    
    private init() {
        
    };
}
