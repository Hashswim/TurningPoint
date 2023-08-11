//
//  autoTradingAppTests.swift
//  autoTradingAppTests
//
//  Created by 서수영 on 2023/08/10.
//

import XCTest
@testable import autoTradingApp

final class autoTradingAppTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testNetworkMethod() {
        let network = NetworkManager()

        DispatchQueue.global().sync {
            network.getAccessToken {
                print("successs")
            }
        }

//        XCTAssertEqual()
    }
}
