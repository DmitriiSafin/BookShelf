//
//  BookModel.swift
//  BookShelf
//
//  Created by Дмитрий on 19.04.2023.
//

import Foundation

struct Results: Decodable {
    let docs: [BookModel]
}

struct BookModel: Decodable {
    let title: String?
    let firstPublishYear: Int?
    let image: String?
    let firstSentence: [String]?
    let ratingsAverage: Double?
    
    enum CodingKeys: String, CodingKey {
        case title
        case firstPublishYear = "first_publish_year"
        case image = "cover_edition_key"
        case firstSentence = "first_sentence"
        case ratingsAverage = "ratings_average"
    }
}
