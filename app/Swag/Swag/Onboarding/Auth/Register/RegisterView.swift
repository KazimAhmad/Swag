//
//  RegisterView.swift
//  Swag
//
//  Created by Kazim Ahmad on 08/01/2026.
//

import SwiftUI

struct RegisterView<ViewModel: RegisterViewModelProtocol>: View {
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
            
            TextField("Username",
                      text: $viewModel.username)
            .textFieldStyle(RoundedShadowTextFieldStyle())
            TextField("Email",
                      text: $viewModel.email)
            .textFieldStyle(RoundedShadowTextFieldStyle())
            TextField("Password",
                      text: $viewModel.password)
            .textFieldStyle(RoundedShadowTextFieldStyle())
            
            Button("Register") {
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
    RegisterView(viewModel: RegisterViewModel())
}
