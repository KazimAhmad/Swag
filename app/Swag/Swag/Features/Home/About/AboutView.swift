//
//  AboutView.swift
//  Swag
//
//  Created by Kazim Ahmad on 15/01/2026.
//

import SwiftUI

struct AboutView: View {
    @StateObject var viewModel: AboutViewModel
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                if viewModel.viewState == .loading {
                    LoadingView()
                } else if case .error(_) = viewModel.viewState {
                    AlertView {
                        viewModel.close()
                    }
                } else {
                    GeometryReader { gr in
                        ZStack {
                            ScrollView {
                                aboutBody(width: gr.size.width)
                                abooutMe()
                                companySize()
                                story()
                            }
                            VStack {
                                Spacer()
                                socialMediaFooter()
                            }
                        }
                    }
                }
            }
            .font(AppTypography.body(size: 18))
        }
        .padding()
        .task {
            viewModel.fetchAbout()
        }
    }
    
    private func aboutBody(width: CGFloat) -> some View {
        VStack {
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.darkPurple)
                .frame(width: 60, height: 4)
            if let url = viewModel.about?.coverImage {
                AsyncImage(url: URL(string: url)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: width)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                } placeholder: {
                    ProgressView()
                        .tint(Color.accentColor)
                        .frame(width: width, height: width / 2)
                }
            }
            HStack {
                if let url = viewModel.about?.image {
                    AsyncImage(url: URL(string: url)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 140, height: 140)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                            .tint(Color.accentColor)
                            .frame(width: 140, height: 140)
                    }
                    .overlay {
                        Circle()
                            .stroke(.primary, lineWidth: 4)
                            .fill(Color.clear)
                            .colorInvert()
                    }
                }
                VStack(alignment: .leading, spacing: 4) {
                    Spacer()
                    Text(viewModel.about?.name ?? "")
                        .font(AppTypography.title(size: 20))
                    imageAndText(image: "briefcase.circle",
                                 text: viewModel.about?.industry ?? "")
                    imageAndText(image: "mappin.circle",
                                 text: viewModel.about?.headquarters ?? "")
                }
                Spacer()
            }
            .padding(.top, -60)
            .padding(.leading, 24)
        }
    }
    
    func imageAndText(image: String,
                      text: String) -> some View {
        HStack {
            Image(systemName: image)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(Color.darkPurple)
            Text(text)
                .font(AppTypography.body(size: 16))
        }
    }
    
    func headingView(image: String,
                     text: String) -> some View {
        HStack {
            Image(systemName: image)
                .resizable()
                .frame(width: 20, height: 20)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.accentColor)
                )
            Text(text)
                .font(AppTypography.body(size: 18))
                .padding(.vertical, 10)
                .padding(.horizontal, 24)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.accentColor)
                )
        }
        .foregroundStyle(Color.white)
    }
    
    func abooutMe() -> some View {
        VStack(alignment: .leading) {
            headingView(image: "pencil.circle",
                        text: "About Me")
            Text(viewModel.about?.description ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    func companySize() -> some View {
        VStack(alignment: .leading) {
            headingView(image: "figure.2.circle",
                        text: "Company Size")
            Text(viewModel.about?.companySize ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    func story() -> some View {
        VStack(alignment: .leading) {
            headingView(image: "book.circle",
                        text: "My Story")
            Text(viewModel.about?.myStory ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    func socialMediaFooter() -> some View {
        HStack {
            Button {
                
            } label: {
                Image(Images.logo)
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.darkPurple)
                .frame(width: 250, height: 60)
        )
    }
}

#Preview {
    AboutView(viewModel: AboutViewModel(coordinator: HomeCoordinator()))
}
