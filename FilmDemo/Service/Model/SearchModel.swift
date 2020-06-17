//
//  SearchModel.swift
//  FilmDemo
//
//  Created by İbrahim DOĞAN on 6/17/20.
//  Copyright © 2020 ibrahimdn. All rights reserved.
//
// MARK: - Search
struct SearchModel: Codable {
    let search: [SearchElement]?
    let totalResults: String?
    let response: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults = "totalResults"
        case response = "Response"
    }
}

// MARK: - SearchElement
struct SearchElement: Codable {
    let title: String?
    let year: String?
    let imdbID: String?
    let type: String?
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
}
