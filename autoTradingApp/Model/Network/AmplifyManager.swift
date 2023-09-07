//
//  AmplifyManager.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/09/06.
//

import Foundation
import Amplify
import Alamofire
import SwiftyJSON
//eventType: getLogo, getStockTrainingData, getAllTrainedList, postSwitchTraining,
//{
//    "eventType": "getLogo",
//    "code": "000111",
//}


struct AmplifyManager {

    func postGetLogo(code: String) async {
//        let message = #"{"eventType": "getLogo", "code": "259960"}"#

        let message = """
        {
            "eventType" : "getLogo",
            "code" : "\(code)"
        }
        """.data(using: .utf8)!

        let request = RESTRequest(path: "/items", body: message)
        do {
            let data = try await Amplify.API.post(request: request)
//            let str = String(decoding: data, as: UTF8.self)
            let json = JSON(data)

            if json["statusCode"] == 200 {
                Stock.homePageDict[code] = json["body"].toString()!
            }

            print(json["body"].stringValue)
        } catch let error as APIError {
            print("Failed due to API error: ", error)
        } catch {
            print("Unexpected error: \(error)")
        }
    }
}

