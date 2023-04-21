//
//  JSONParser.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/04/18.
//

import Foundation

struct JSONParser {
    func decodeJSON<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable  {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)

        let result = try decoder.decode(type, from: data)
        return result
    }

    func encodeJSON<T>(_ value: T) throws -> Data where T : Encodable {
        let encoder = JSONEncoder()
        let result = try encoder.encode(value)

        return result
    }

}
