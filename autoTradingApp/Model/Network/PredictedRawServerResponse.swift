//
//  PredictedRawServerResponse.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/04/21.
//

struct PredictedRawServerResponse {

    enum RootKeys: String, CodingKey {
        case statusCode, body, headers
    }

    enum HeaderKeys: String, CodingKey {
        case contentType = "Content-Type"
        case acao = "Access-Control-Allow-Origin"
    }

    enum BodyKeys: String, CodingKey {
        case body
    }

    let statusCode: Int
    let body: String
    let contentType: String
    let acao: String

}

extension PredictedRawServerResponse: Decodable {

    init(from decoder: Decoder) throws {
        // id
        let container = try decoder.container(keyedBy: RootKeys.self)
        statusCode = try container.decode(Int.self, forKey: .statusCode)

        // body
        body = try container.decode(String.self, forKey: .body)

        // headers
        let headerContainer = try container.nestedContainer(keyedBy: HeaderKeys.self, forKey: .headers)
        contentType = try headerContainer.decode(String.self, forKey: .contentType)
        acao = try headerContainer.decode(String.self, forKey: .acao)
    }

}
