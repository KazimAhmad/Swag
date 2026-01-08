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
            VStack {
                
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel())
}
