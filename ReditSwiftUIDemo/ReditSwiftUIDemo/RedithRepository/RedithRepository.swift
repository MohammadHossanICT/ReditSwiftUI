//
//  RedithRepository.swift
//  ReditSwiftUIDemo
//
//  Created by M A Hossan on 17/04/2023.
//

import Foundation

protocol RedithRepository{
    func getList(for url: URL) async throws -> RedditResponse
}

struct RedithRepositoryImplementation {
    private let networkManager: Fetchable

    init(networkManager: Fetchable) {
        self.networkManager = networkManager
    }
}

extension RedithRepositoryImplementation: RedithRepository, JsonParser {
    func getList(for url: URL) async throws -> RedditResponse {
        do {
            let listsData = try await networkManager.get(url: url)
            return try parse(data: listsData, type: RedditResponse.self)
        } catch {
            throw error
        }
    }
}
