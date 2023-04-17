//
//  ReditSwiftUIDemoApp.swift
//  ReditSwiftUIDemo
//
//  Created by M A Hossan on 17/04/2023.
//

import SwiftUI

@main
struct ReditSwiftUIDemoApp: App {
    var body: some Scene {
        WindowGroup {
            RedithListView(viewModel: RedithListViewModel(repository: RedithRepositoryImplementation(networkManager: NetworkManager())))
        }
    }
}
