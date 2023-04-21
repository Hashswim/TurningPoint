//
//  NetworkManager.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/04/14.

import UIKit

struct NetworkManager {
    typealias StatusCode = Int
    let jsonParser = JSONParser()
    let cache: URLCache = {
        let cache = URLCache.shared
        cache.memoryCapacity = 0
        cache.diskCapacity = 0
        return cache
    }()

    private func generateURL(type: RequestType) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        //        components.host = "openmarket.yagom-academy.kr"

        switch type {

        case .stockAPITest:
            components.host = "6rct6x0ix0.execute-api.us-east-1.amazonaws.com"
            components.path = "/test-stage/at-api-test"

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
