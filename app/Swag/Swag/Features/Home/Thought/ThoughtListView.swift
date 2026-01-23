//
//  ThoughtListView.swift
//  Swag
//
//  Created by Kazim Ahmad on 23/01/2026.
//

import SwiftUI

struct ThoughtListView: View {
    @StateObject var viewModel: ThoughtListViewModel
    init(viewModel: ThoughtListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            switch viewModel.viewState {
            case .loading:
                LoadingView()
            case .error(_):
                AlertView()
            case .empty:
                ThoughtView(thought: Thought(id: 0,
                                             thought: "",
                                             more: "",
                                             date: Date()), seeMore: {})
            case .info:
                thoughtList()
            }
        }
        .task {
            viewModel.getThoughts()
        }
        .navigationTitle("Thoughts")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func thoughtList() -> some View {
        VStack {
            List {
                ForEach(viewModel.thoughts, id: \.id) { thought in
                    ThoughtView(thought: thought) {
                        viewModel.seeMore(of: thought)
                    }
                    .listRowInsets(.init())
                    .listRowBackground(Color.clear)
                }
                if viewModel.hasMoreThoughts() {
                    LoadingView()
                        .onAppear {
                            viewModel.getThoughts()
                        }
                }
            }
            .listStyle(.plain)
            .refreshable {
                viewModel.refresh()
            }
            Spacer()
        }
    }
}

#Preview {
    ThoughtListView(viewModel: ThoughtListViewModel(coordinator: HomeCoordinator()))
}
