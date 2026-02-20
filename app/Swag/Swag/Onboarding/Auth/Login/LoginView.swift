//
//  Login.swift
//  Swag
//
//  Created by Kazim Ahmad on 07/01/2026.
//

import SwiftUI

struct LoginView<ViewModel: LoginViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            LampAndLightView()
            loginForm()
        }
        .ignoresSafeArea()
    }
    
    func loginForm() -> some View {
        VStack {
            Image(Images.logo)
                .resizable()
                .frame(width: 100,
                       height: 100)
                .padding(.vertical)
            
            TextField("Email or username",
                      text: $viewModel.emailOrUsername)
            .textFieldStyle(RoundedShadowTextFieldStyle())
            ZStack {
                if viewModel.isSecured {
                    SecureField("Password",
                                text: $viewModel.password)
                    .textFieldStyle(RoundedShadowTextFieldStyle())
                } else {
                    TextField("Password",
                              text: $viewModel.password)
                    .textFieldStyle(RoundedShadowTextFieldStyle())
                }
                HStack {
                    Spacer()
                    Button {
                        viewModel.isSecured.toggle()
                        viewModel.showAnimation()
                    } label: {
                        Image(systemName: viewModel.eyeImage)
                            .resizable()
                            .frame(width: 24, height: 22)
                            .foregroundStyle(.purple)
                            .padding(.trailing)
                    }
                }
            }
            
            Button("Login") {
                print("Tapped")
            }
            .buttonStyle(
                RoundedBorderButtonStyle()
            )
            .padding(.vertical)
        }
        .padding()
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel(coordinator: OnboardingCoordiantor()))
}
