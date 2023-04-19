//
//  APIManager.swift
//  BookShelf
//
//  Created by Дмитрий on 19.04.2023.
//

import Foundation

protocol ApiManagerProtocol {
    func fetchBooks(title: String) async throws -> BookModel
}

final class ApiManager {
    private let networkManager: NetworkManagerProtocol
    
    init(
        networkManager: NetworkManagerProtocol
    ) {
        self.networkManager = networkManager
    }
}

extension ApiManager: ApiManagerProtocol {
    
    func fetchBooks(title: String) async throws -> BookModel {
        let urlString = "https://openlibrary.org/search.json?title=\(title)"
        return try await networkManager.request(urlString: urlString)
    }
    
}

