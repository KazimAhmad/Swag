//
//  OnboardingView.swift
//  Swag
//
//  Created by Kazim Ahmad on 10/01/2026.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            logoFloatingHeader()
            headerView()
            butttonsView()
            Spacer()
        }
        .padding(.horizontal)
    }
    
    func headerView() -> some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                Text("Welcome to the catalog of")
                    .font(AppTypography.note(size: 28))
                Text("Junaid Akram")
                    .font(AppTypography.title(size: 32))
            }
            Spacer()
            Image(Images.logo)
                .resizable()
                .frame(width: 80, height: 80)
        }
        .foregroundColor(.primary)
    }
        
    func butttonsView() -> some View {
        VStack {
            Button {
                viewModel.goToLogin()
            } label: {
                Text("Login")
                    .frame(height: 28)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(
                RoundedBorderButtonStyle(backgroundColor: .accentColor,
                                         borderColor: .accentColor,
                                         cornerRadius: 28)
            )
            
            Button {
                viewModel.goToRegister()
            } label: {
                Text("Register")
                    .frame(height: 28)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(
                RoundedBorderButtonStyle(backgroundColor: .darkerOrange,
                                         borderColor: .darkerOrange,
                                         cornerRadius: 28)
            )
            
            Button {
                viewModel.enterAsGuest()
            } label: {
                Text("Enter as guest")
                    .frame(height: 28)
                    .foregroundStyle(Color.primary)
                    .padding(.vertical)
            }
        }
        .font(AppTypography.title(size: 18))
    }
    
    private func logoFloatingHeader() -> some View {
        VStack {
            HStack {
                ForEach(0 ..< OnboardingInfoType.allCases.count, id: \.self) { index in
                    let type = OnboardingInfoType.allCases[index]
                    logoFloatingBar(image: type.image,
                                    offsetMultiplier: CGFloat(index + 1))
                }
            }
            .padding(.trailing, 40)
            .rotationEffect(Angle(degrees: -20))
            .ignoresSafeArea(edges: .top)
            Spacer()
        }
    }
    
    private func logoFloatingBar(image: String,
                                 color: Color = .darkPurple,
                                 offsetMultiplier: CGFloat = 1) -> some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(color)
            .frame(width: 60,
                   height: 400)
            .overlay {
                VStack {
                    Spacer()
                    Image(systemName: image)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.lampLight)
                        .padding(.bottom)
                }
            }
            .offset(y: -(50 * offsetMultiplier))
            .shadow(color: .primary.opacity(0.4),
                    radius: 8)
    }
}

#Preview {
    OnboardingView(viewModel: OnboardingViewModel(coordinator: OnboardingCoordiantor()))
}
