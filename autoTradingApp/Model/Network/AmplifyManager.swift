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
//eventType: getLogo, getStockTrainingData, getAllTrainedList, postSwitchTraining, getPredictedTransaction
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

    func postGetAllTrainedList() async -> ([String], [String]) {
//        let message = #"{"eventType": "getLogo", "code": "259960"}"#

        let message = """
        {
            "eventType" : "getAllTrainedList"
        }
        """.data(using: .utf8)!

        let request = RESTRequest(path: "/items", body: message)
        do {
            let data = try await Amplify.API.post(request: request)
//            let str = String(decoding: data, as: UTF8.self)
            let json = JSON(data)

            //            json["body"]
            if json["statusCode"] == 200 {
//                Stock.homePageDict[code] = json["body"].toString()!
            }
            print(json["body"].type)
            let codeArr: [String] = json["body"]["code"].array?.compactMap { $0.stringValue } ?? []
            let nameArr: [String] = json["body"]["name"].array?.compactMap { $0.stringValue } ?? []
//
            return (codeArr, nameArr)
        } catch let error as APIError {
            print("Failed due to API error: ", error)
        } catch {
            print("Unexpected error: \(error)")
        }
        return ([], [])
    }

    func postGetStockTrainingData(code: String) async -> [AlgorithmModel] {
//        let message = #"{"eventType": "getLogo", "code": "259960"}"#

        let message = """
        {
            "eventType" : "getStockTrainingData",
            "code" : "\(code)"

        }
        """.data(using: .utf8)!

        let request = RESTRequest(path: "/items", body: message)
        do {
            let data = try await Amplify.API.post(request: request)
            let json = JSON(data)

            if json["statusCode"] == 200 {
                return (json["body"].array?.compactMap {
                    AlgorithmModel(algorithmType: $0["modelName"].stringValue, predictedProfit: $0["predictedProfit"].doubleValue)
                }) as! [AlgorithmModel]
            } else {
                return []
            }
        } catch let error as APIError {
            print("Failed due to API error: ", error)
            return []
        } catch {
            print("Unexpected error: \(error)")
            return []
        }
    }
}

