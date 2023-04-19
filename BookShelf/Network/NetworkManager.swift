//
//  NetworkManager.swift
//  BookShelf
//
//  Created by Дмитрий on 19.04.2023.
//

import Foundation

protocol NetworkManagerProtocol {
    func request<T: Decodable>(urlString: String) async throws -> T
}

public final class NetworkManager {
    private let jsonService: JSONDecoderManagerProtocol
    init(jsonService: JSONDecoderManagerProtocol) {
        self.jsonService = jsonService
    }
}

extension NetworkManager: NetworkManagerProtocol {
    
    func request<T: Decodable>(urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.url
        }
        let urlRequest = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        return try jsonService.decode(data)
    }
}

enum NetworkError: Error {
    case url
}
