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
            Button {
                viewModel.goToLogin()
            } label: {
                Text("login")
            }
            
            Button {
                viewModel.goToRegister()
            } label: {
                Text("register")
            }
        }
    }
}

#Preview {
    OnboardingView(viewModel: OnboardingViewModel(coordinator: OnboardingCoordiantor()))
}
