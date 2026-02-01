//
//  HomeView.swift
//  Swag
//
//  Created by Kazim Ahmad on 15/01/2026.
//

import SwiftUI

struct HomeView<ViewModel: HomeViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        ScrollView {
            VStack {
                headerView()
                    .padding(.bottom, 24)
                infoView()
                    .onTapGesture {
                        viewModel.showAbout()
                    }
                thoughtOfTheDayView()
            }
        }
        .task {
            viewModel.getThoughtOfDay()
        }
        .ignoresSafeArea(edges: .all)
    }
    
    private func headerView() -> some View {
        ZStack {
            HStack {
                Rectangle()
                    .fill(Color.purple)
                    .frame(width: 200,
                           height: 200)
                    .rotationEffect(.degrees(-20))
                    .offset(y: -24)
                Spacer()
            }
            HStack(alignment: .bottom, spacing: 0) {
                Image(Images.logo)
                    .resizable()
                    .frame(width: 120,
                           height: 120)
                Text("Junaid Akram")
                    .font(AppTypography.title(size: 24))
                    .padding(.bottom)
                    .overlay {
                        HStack {
                            RoundedRectangle(cornerRadius: 1)
                                .fill(Color.purple)
                                .frame(width: 40, height: 3)
                                .offset(y: 16)
                            Spacer()
                        }
                    }
                Spacer()
            }
            .offset(y: 60)
            .padding(.horizontal)
        }
    }
    
    func infoView() -> some View {
        VStack(alignment: .leading) {
            Text(viewModel.info)
                .font(AppTypography.body(size: 14))
                .multilineTextAlignment(.leading)
            Text("More about me...")
                .font(AppTypography.body(size: 16))
                .foregroundStyle(Color.accentColor)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
    }
    
    func thoughtOfTheDayView() -> some View {
        Section {
            if let thought = viewModel.thoughtOfTheDay {
                ThoughtView(thought: thought) {
                    viewModel.seeMore(of: thought)
                }
            } else {
                ThoughtView(thought: Thought(id: 1,
                                             thought: "",
                                             more: "",
                                             date: Date())) {}
            }
        } header: {
            HStack {
                Spacer()
                Button {
                    viewModel.thoughtList()
                } label: {
                    Text("See all")
                        .font(AppTypography.body(size: 16))
                        .offset(y: 24)
                        .padding(.trailing, 32)
                }
            }
            .foregroundStyle(Color.purple)
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(coordinator: HomeCoordinator(),
                                      thoughtRepo: ThoughtRepository()))
}
