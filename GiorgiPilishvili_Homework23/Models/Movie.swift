//
//  Show.swift
//  GiorgiPilishvili_Homework23
//
//  Created by GIORGI PILISSHVILI on 16.08.22.
//

import Foundation

struct MovieResponseData: Codable {
    
    struct Movie: Codable {
        
        enum CodingKeys: String, CodingKey {
            case id, name, overview
            case voteCount = "vote_count"
            case voteAverage = "vote_average"
        }
        
        let id: Int
        let name: String
        let overview: String
        let voteCount: Int
        let voteAverage: Double
    }
    
    // Movie Response Data
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
    
    let page: Int
    let results: [Movie]
    let totalResults: Int
    let totalPages: Int
    
}

struct MovieDetails: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case numberOfEpisodes = "number_of_episodes"
    }
    
    let id: Int
    let name: String
    let numberOfEpisodes: Int
    
}
