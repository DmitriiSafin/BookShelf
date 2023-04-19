//
//  JSONDecoderManager.swift
//  BookShelf
//
//  Created by Дмитрий on 19.04.2023.
//

import Foundation

protocol JSONDecoderManagerProtocol {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

final class JSONDecoderManager {
    
    private let decoder = JSONDecoder()
    public init() {}
}

extension JSONDecoderManager: JSONDecoderManagerProtocol {

    func decode<T: Decodable>(_ data: Data) throws -> T {
            return try decoder.decode(T.self, from: data)
    }
}
