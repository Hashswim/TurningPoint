//
//  NetworkManager.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/04/14.

import UIKit
import Alamofire
import SwiftyJSON
/**
 appkey : PSDOHWlJurdHdb9xfIq8K8WyJwpW735MGnLb
 secretkey : 9x8MoEJlkpbG6RunMhXU1RTeCQgV9ra2
 **/
struct NetworkManager {
    typealias StatusCode = Int
    //    lazy var accessToken = String()
    let jsonParser = JSONParser()

    private func generateURL(type: RequestType) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "openapi.ebestsec.co.kr:8080"

        switch type {

        case .stockAPITest:
            components.host = "6rct6x0ix0.execute-api.us-east-1.amazonaws.com"
            components.path = "/test-stage/at-api-test"

            return components.url?.absoluteURL

            //        case .getAccessToken(let appkey, let secretKey):
            //            components.path = "/oauth2/token"
            //            components.queryItems = [
            //                URLQueryItem(name: "grant_type", value: "client_credentials"),
            //                URLQueryItem(name:  "appkey", value: "\(appkey)"),
            //                URLQueryItem(name: "appsecretkey", value: "\(secretKey)"),
            //                URLQueryItem(name:  "scope", value: "oob"),
            //            ]
            //
            //            return components.url?.absoluteURL
        }
    }


    private func isSuccessResponse(response: URLResponse?, error: Error?) -> Bool {
        let successRange = 200..<300
        guard error == nil,
              let statusCode = (response as? HTTPURLResponse)?.statusCode,
              successRange.contains(statusCode) else {
            return false
        }

        return true
    }
}

// MARK: - GET Method
extension NetworkManager {
    func getStockAPITest(completion: @escaping (PredictedRawServerResponse) -> Void) {
        guard let url = generateURL(type: .stockAPITest) else {
            return
        }

        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if isSuccessResponse(response: response, error: error) == false {
                return
            }

            guard let data = data else {
                return
            }

            do {
                let result = try jsonParser.decodeJSON(PredictedRawServerResponse.self, from: data)
                completion(result)
            } catch {
                print(error)
            }
        }

        dataTask.resume()
    }
}


// MARK: - POST Method
extension NetworkManager {
//    func getAccessToken() {
//        let url = "https://openapi.ebestsec.co.kr:8080/oauth2/token"
//
//        // Header : 메타정보
//        // Body : 실질적인 데이터
//        let parameter: Parameters = ["appkey":"PSDOHWlJurdHdb9xfIq8K8WyJwpW735MGnLb",                               "appsecretkey":"9x8MoEJlkpbG6RunMhXU1RTeCQgV9ra2",
//                                     "grant_type": "client_credentials",
//                                     "scope": "oob"]
//
//        let header: HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
//
//        AF.request(url,
//                   method: .post,
//                   parameters: parameter,
//                   headers: header).validate(statusCode: 200..<600).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                // 상태코드 - 값이 없으면 500
//                let statusCode = response.response?.statusCode ?? 500
//
//                if statusCode == 200 {
//                    UserInfo.shared.accessToken = json["access_token"].string
//                    print(json["access_token"])
//                } else {
//                    print("error")
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }

    func getAccessToken(appKey: String, secretKey: String, completion: @escaping (String?) -> ()) {
        let url = "https://openapi.ebestsec.co.kr:8080/oauth2/token"

        // Header : 메타정보
        // Body : 실질적인 데이터
        let parameter: Parameters = ["appkey": appKey,
                                     "appsecretkey": secretKey,
                                     "grant_type": "client_credentials",
                                     "scope": "oob"]

        let header: HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]

        AF.request(url,
                   method: .post,
                   parameters: parameter,
                   headers: header).validate(statusCode: 200..<600).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                // 상태코드 - 값이 없으면 500
                let statusCode = response.response?.statusCode ?? 500

                if statusCode == 200 {
                    completion(json["access_token"].string)
//                    print(json["access_token"])
                } else {
                    completion(nil)
                    print("error")
                }
            case .failure(let error):
                completion(nil)
                print(error)
            }
        }
    }

    func getUserAccount(completion: @escaping (Double, Double, [ownedStock]) -> ()){
        let url = "https://openapi.ebestsec.co.kr:8080/stock/accno"

        // Header : 메타정보
        // Body : 실질적인 데이터
        let header: HTTPHeaders = [
            "Content-Type":"application/json;charset=utf-8",
            "authorization": "Bearer \(UserInfo.shared.accessToken!)",
            "tr_cd": "t0424",
            "tr_cont":"N",
            "tr_cont_key":""
        ]

        let parameter: Parameters = [
            "t0424InBlock":
                ["prcgb" : "",
                 "chegb" : "",
                 "dangb" : "",
                 "charge" : "",
                 "cts_expcode" : ""
                ]
        ]

        AF.request(url,
                   method: .post,
                   parameters: parameter,
                   encoding: JSONEncoding.default,
                   headers: header).validate(statusCode: 200..<600).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                // 상태코드 - 값이 없으면 500
                let statusCode = response.response?.statusCode ?? 500

                if statusCode == 200 {

                    completion(
                        json["t0424OutBlock"]["sunamt"].doubleValue,
                        json["t0424OutBlock"]["tdtsunik"].doubleValue,
                        
                        json["t0424OutBlock1"].array!.compactMap {
                        ownedStock(name: $0["hname"].string!,
                                   code: $0["expcode"].string!,
                                   appamt:  $0["appamt"].doubleValue,
                                   dtsunik:  $0["dtsunik"].doubleValue,
                                   sunikrt:  $0["sunikrt"].doubleValue,
                                   janqty:  $0["janqty"].doubleValue) })

                    print(json)
                } else {
                    print("error")
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func getTopTradingVolume(completion: @escaping ([String], [String]) -> () ){
        let url = "https://openapi.ebestsec.co.kr:8080/stock/high-item"

        // Header : 메타정보
        let header: HTTPHeaders = [
            "Content-Type":"application/json;charset=utf-8",
            "authorization": "Bearer \(UserInfo.shared.accessToken!)",
            "tr_cd": "t1452",
            "tr_cont":"N",
            "tr_cont_key":""
        ]


        // Body : 실질적인 데이터
        let parameter: Parameters = [
            "t1452InBlock":
                [ "gubun" : "1",
                  "jnilgubun" : "1",
                  "sdiff" : 0,
                  "ediff" : 0,
                  "jc_num" : 0,
                  "sprice" : 0,
                  "eprice" : 0,
                  "volume" : 0,
                  "idx" : 0
                ]
        ]

        AF.request(url,
                   method: .post,
                   parameters: parameter,
                   encoding: JSONEncoding.default,
                   headers: header).validate(statusCode: 200..<600).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                // 상태코드 - 값이 없으면 500
                let statusCode = response.response?.statusCode ?? 500

                if statusCode == 200 {
                    let nameArr: [String] = (json["t1452OutBlock1"].array?.compactMap { $0["hname"].string })!
                    let codeArr: [String] = (json["t1452OutBlock1"].array?.compactMap { $0["shcode"].string })!

                    completion(nameArr, codeArr)
                } else {
                    print("error")
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func getNowPrice(code: String, idx: Int, completion: @escaping (String, String, Int, Double, Double, Double, Double) -> ()) {
        let url = "https://openapi.ebestsec.co.kr:8080/stock/market-data"

        // Header : 메타정보
        // Body : 실질적인 데이터
        let parameter: Parameters = [
            "t1101InBlock": ["shcode": "\(code)"]
        ]


        let header: HTTPHeaders = [
            "content-type":"application/json; charset=utf-8",
            "authorization": "Bearer \(UserInfo.shared.accessToken!)",
            "tr_cd":"t1101",
            "tr_cont":"N",
            "tr_cont_key":"",
        ]

        AF.request(url,
                   method: .post,
                   parameters: parameter,
                   encoding: JSONEncoding.default,
                   headers: header).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                // 상태코드 - 값이 없으면 500
                let statusCode = response.response?.statusCode ?? 500

                if statusCode == 200 {
                    //                    print(code, json["t1101OutBlock"]["diff"], json["t1101OutBlock"]["hname"])
                    completion("\(json["t1101OutBlock"]["hname"])",
                               code,
                               idx,
                               json["t1101OutBlock"]["price"].doubleValue,
                               json["t1101OutBlock"]["diff"].doubleValue,
                               json["t1101OutBlock"]["volume"].doubleValue,
                               json["t1101OutBlock"]["change"].doubleValue)
                    //                    print(json)
                } else {
                    print("error", "\(code)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func getDateChart(code: String, idx: Int, completion: @escaping (String, Int, [DateChart]) -> ()) {
        let url = "https://openapi.ebestsec.co.kr:8080/stock/chart"

        // Header : 메타정보
        // Body : 실질적인 데이터
        let parameter: Parameters = [
            "t8410InBlock": ["shcode": "\(code)",
                             "gubun" : "2",
                             "qrycnt" : 500,
                             "sdate" : "20230101",
                             "edate" : "당일",
                             "cts_date" : "",
                             "comp_yn" : "N",
                             "sujung" : "Y"
                            ]
        ]


        let header: HTTPHeaders = [
            "content-type":"application/json; charset=utf-8",
            "authorization": "Bearer \(UserInfo.shared.accessToken!)",
            "tr_cd":"t8410",
            "tr_cont":"N",
            "tr_cont_key":"",
        ]

        

        AF.request(url,
                   method: .post,
                   parameters: parameter,
                   encoding: JSONEncoding.default,
                   headers: header).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                // 상태코드 - 값이 없으면 500
                let statusCode = response.response?.statusCode ?? 500

                if statusCode == 200 {
                    print(json)
                    let dateChartList = json["t8410OutBlock1"].array?.compactMap {
                        DateChart(
                            date: $0["date"].stringValue,
                            high: $0["high"].doubleValue,
                            low: $0["low"].doubleValue,
                            open: $0["open"].doubleValue,
                            close: $0["close"].doubleValue)
                    }
                    completion(code, idx, dateChartList!)
                } else {
                    print("error", "\(code)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func postOrder(code: String, count: Int, price: Double, trType: Int,  completion: @escaping () -> ()) {
        let url = "https://openapi.ebestsec.co.kr:8080/stock/chart"

        // Header : 메타정보
        // Body : 실질적인 데이터

        //trType - 1:매도, 2: 매수
        let parameter: Parameters = [
            "CSPAT00601InBlock1": ["RecCnt": 1,
                                   "IsuNo": "\(code)",
                                   "OrdQty": count,
                                   "OrdPrc": price,
                                   "BnsTpCode": "\(trType)",
                                   "OrdprcPtnCode": "00",
                                   "PrgmOrdprcPtnCode": "00",
                                   "StslAbleYn": "0",
                                   "StslOrdprcTpCode": "0",
                                   "CommdaCode": "41",
                                   "MgntrnCode": "000",
                                   "LoanDt": "",
                                   "MbrNo": "000",
                                   "OrdCndiTpCode": "0",
                                   "StrtgCode": " ",
                                   "GrpId": " ",
                                   "OrdSeqNo": 0,
                                   "PtflNo": 0,
                                   "BskNo": 0,
                                   "TrchNo": 0,
                                   "ItemNo": 0,
                                   "OpDrtnNo": "0",
                                   "LpYn": "0",
                                   "CvrgTpCode": "0"
                                  ]
        ]


        let header: HTTPHeaders = [
            "content-type":"application/json; charset=utf-8",
            "authorization": "Bearer \(UserInfo.shared.accessToken!)",
            "tr_cd":"CSPAT00601",
            "tr_cont":"N",
            "tr_cont_key":"",
        ]



        AF.request(url,
                   method: .post,
                   parameters: parameter,
                   encoding: JSONEncoding.default,
                   headers: header).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                // 상태코드 - 값이 없으면 500
                let statusCode = response.response?.statusCode ?? 500

                if statusCode == 200 {
                    //                    print(code, json["t1101OutBlock"]["price"], json["t1101OutBlock"]["hname"])
                    print(json)
                    completion()
                } else {
                    print("error", "\(code)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func getLogo(code: String, idx: Int, completion: @escaping (Int, UIImage) -> ()) {
        let url = URL(string: Stock.homePageDict[code] ?? "https://logo.clearbit.com/https://www.naver.com")!

        AF.request(url,
                   method: .get).response{ response in
            switch response.result {
            case .success(let responseData):
                completion(idx, UIImage(data: responseData!, scale:1) ?? UIImage())
            case .failure(let error):
                print("error--->",error)
            }
        }
    }
}
