//
//  RedithListView.swift
//  ReditSwiftUIDemo
//
//  Created by M A Hossan on 17/04/2023.
//

import SwiftUI

struct RedithListView: View {
    @StateObject var viewModel: RedithListViewModel

    var body: some View {
        NavigationStack {
            VStack{
                if viewModel.customError != nil && !viewModel.refreshing {
                  alertView()
                } else {
                    if viewModel.refreshing {
                        progressView()
                    }
                    if viewModel.storyLists.count > 0 && !viewModel.refreshing {
                        List(viewModel.storyLists) {
                            story in
                            RedithCellView(story: story)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    getToolBarView()
                }
            }
            .navigationTitle(Text("Story List"))
        }.task{
            await getDataFromAPI()
        }
        .refreshable {
            await getDataFromAPI()
        }
    }

    func getDataFromAPI() async {
        await viewModel.getStoryList(urlStr: NetworkURL.urlBase)
    }

    @ViewBuilder
    func getToolBarView() -> some View {
        Button {
            Task{
                await getDataFromAPI()
            }
        } label: {
            HStack {
                Image(systemName: "arrow.clockwise")
                    .padding(.all, 10.0)
            }.fixedSize()
        }
        .cornerRadius(5.0)
    }

    @ViewBuilder
    func progressView() -> some View {
        VStack{
            RoundedRectangle(cornerRadius: 15)
            .fill(.white)
            .frame(height: 180)
            .overlay{
                VStack{
                    ProgressView().padding(50)
                    Text("Please Wait Message").font(.headline)
                }
            }
        }
    }

    @ViewBuilder
    func alertView() -> some View {
        Text("").alert(isPresented: $viewModel.isErrorOccured) {
            Alert(title: Text("General_Error"), message: Text(viewModel.customError?.localizedDescription ?? ""),dismissButton: .default(Text("Okay")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RedithListView(viewModel: RedithListViewModel(repository: RedithRepositoryImplementation(networkManager: NetworkManager())))
    }
}

