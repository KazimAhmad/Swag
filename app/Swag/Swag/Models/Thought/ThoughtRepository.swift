//
//  ThoughtRepository.swift
//  SwagAdmin
//
//  Created by Kazim Ahmad on 24/01/2026.
//

import Combine
import CoreData
import Foundation

protocol ThoughtRepositoryProtocol {
    func fetch(for page: Int) async throws -> ThoughtObject
    func create(thought: String, more: String) async throws -> Int
    func delete(for ids: [Int]) async throws
    func oftheday() async throws -> Thought
}

final class ThoughtRepository: ThoughtRepositoryProtocol {
    func fetch(for page: Int) async throws -> ThoughtObject {
        let thoughtsEndpoint = ThoughtEndpoint.list(page)
        return try await SwiftServices.shared.request(endpoint: thoughtsEndpoint)
    }
    
    func create(thought: String, more: String) async throws -> Int {
        let thoughtsEndpoint = ThoughtEndpoint.add(thought, more)
        struct NewThoughtId: Codable {
            let id: Int
        }
        let newThoughIdObj: NewThoughtId = try await SwiftServices.shared.request(endpoint: thoughtsEndpoint)
        return newThoughIdObj.id
    }
    
    func delete(for ids: [Int]) async throws {
        let thoughtsEndpoint = ThoughtEndpoint.delete(ids)
        return try await SwiftServices.shared.request(endpoint: thoughtsEndpoint)
    }
    
    func oftheday() async throws -> Thought {
        let ofTheDayEndpoint = ThoughtEndpoint.ofTheDay
        return try await SwiftServices.shared.request(endpoint: ofTheDayEndpoint)
    }
}
