//
//  RedithListViewModel.swift
//  ReditSwiftUIDemo
//
//  Created by M A Hossan on 17/04/2023.
//

import Foundation

import Foundation
import Combine

protocol RedithListViewModelAction: ObservableObject {
    func getStoryList(urlStr: String) async
}

@MainActor
final class RedithListViewModel {
    @Published private(set) var storyLists: [Story] = []
    @Published private(set) var customError: NetworkError?
    @Published private(set) var refreshing = true
    @Published var isErrorOccured = false

    private let repository: RedithRepository
    init(repository: RedithRepository) {
        self.repository = repository
    }
}
extension RedithListViewModel: RedithListViewModelAction {
    func getStoryList(urlStr: String) async {
        refreshing = true
        guard let url = URL(string: urlStr) else {
                self.customError = NetworkError.invalidURL
            refreshing = false
            isErrorOccured = false
            return
        }
        do {
            let lists = try await repository.getList(for: url)
            let arr = lists.data.children.map { $0.data }
            refreshing = false
            isErrorOccured = false
            storyLists = arr

        } catch {
            refreshing = false
            isErrorOccured = true
            customError = error as? NetworkError
        }
    }
}

