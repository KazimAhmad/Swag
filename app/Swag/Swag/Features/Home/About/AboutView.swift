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
                                moreInfo()
                                    .padding(.bottom, 80)
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
                .fill(Color.purple)
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
                            .stroke(Color(uiColor: UIColor.systemBackground), lineWidth: 4)
                            .fill(Color.clear)
                    }
                }
                VStack(alignment: .leading, spacing: 4) {
                    Spacer()
                    Text(viewModel.about?.name ?? "")
                        .font(AppTypography.title(size: 20))
                    imageAndText(image: Images.industry,
                                 text: viewModel.about?.industry ?? "")
                    imageAndText(image: Images.headquarters,
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
                .foregroundStyle(Color.accentColor)
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
    
    func infoSection(image: String,
                     text: String,
                     info: String?) -> some View {
        VStack(alignment: .leading) {
            headingView(image: Images.about,
                        text: "About Me")
            Text(info ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.purple)
                .frame(width: 100, height: 2)
        }
    }
    
    func moreInfo() -> some View {
        VStack(alignment: .leading) {
            infoSection(image: Images.about,
                        text: "About Me",
                        info: viewModel.about?.description)
            infoSection(image: Images.company,
                        text: "Company Size",
                        info: viewModel.about?.companySize)
            infoSection(image: Images.story,
                        text: "My Story",
                        info: viewModel.about?.myStory)
        }
    }
    
    func socialMediaButton(image: String,
                           link: String) -> some View {
        Button {
            if let url = URL(string: link) {
               UIApplication.shared.open(url)
            }
        } label: {
            Image(image)
                .resizable()
                .frame(width: 30, height: 30)
        }
    }
    
    func socialMediaFooter() -> some View {
        HStack(spacing: 24) {
            socialMediaButton(image: Images.facebook,
                              link: viewModel.about?.socialMedia.facebook ?? "")
            socialMediaButton(image: Images.insta,
                              link: viewModel.about?.socialMedia.instagram ?? "")
            socialMediaButton(image: Images.youtube,
                              link: viewModel.about?.socialMedia.youTube ?? "")
            socialMediaButton(image: Images.patreon,
                              link: viewModel.about?.socialMedia.patreon ?? "")
        }
        .foregroundStyle(.white)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.darkerOrange)
                .frame(width: 230, height: 60)
                .shadow(color: Color.primary.opacity(0.6),
                        radius: 16)
        )
    }
}

#Preview {
    AboutView(viewModel: AboutViewModel(coordinator: HomeCoordinator()))
}
