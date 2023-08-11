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

        case .getAccessToken(let appkey, let secretKey):
            components.path = "/oauth2/token"
            components.queryItems = [
                URLQueryItem(name: "grant_type", value: "client_credentials"),
                URLQueryItem(name:  "appkey", value: "\(appkey)"),
                URLQueryItem(name: "appsecretkey", value: "\(secretKey)"),
                URLQueryItem(name:  "scope", value: "oob"),
            ]

            return components.url?.absoluteURL
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
    func getAccessToken() {
        let url = "https://openapi.ebestsec.co.kr:8080/oauth2/token"

        // Header : 메타정보
        // Body : 실질적인 데이터
        let parameter: Parameters = ["appkey":"PSDOHWlJurdHdb9xfIq8K8WyJwpW735MGnLb",                               "appsecretkey":"9x8MoEJlkpbG6RunMhXU1RTeCQgV9ra2",
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
                    print(json["access_token"])
                } else {
                    print("error")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
