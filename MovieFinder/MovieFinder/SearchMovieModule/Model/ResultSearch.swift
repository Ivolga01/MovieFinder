//
//  ResultSearch.swift
//  MovieFinder
//
//  Created by Тамара Иволга on 12.04.2022.
//

import UIKit

// MARK: - ResultSearch
struct ResultSearch: Codable {
    let searchType: String
    let expression: String
    let results: [Results]
    let errorMessage: String
}

// MARK: - Result
struct Results: Codable, Equatable {
    let id, resultType: String
    let image: String
    let title, resultDescription: String

    enum CodingKeys: String, CodingKey {
        case id, resultType, image, title
        case resultDescription = "description"
    }
}
