//
//  Thought.swift
//  Swag
//
//  Created by Kazim Ahmad on 19/01/2026.
//

import Foundation

struct ThoughtObject: Decodable {
    let total: Int
    let items: [Thought]
}

struct ThoughtOfTheday: Decodable {
    let thoughtsOfTheDay: [Thought]
    enum CodingKeys: String, CodingKey {
        case thoughtsOfTheDay = "thought_of_day"
    }
}

struct Thought: Codable {
    var id: Int
    var thought: String
    var more: String
    var date: Date
}
