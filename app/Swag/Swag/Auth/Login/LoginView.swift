//
//  Login.swift
//  Swag
//
//  Created by Kazim Ahmad on 07/01/2026.
//

import SwiftUI

struct LoginView<ViewModel: LoginViewModelProtocol>: View {
    @Environment(\.colorScheme) private var colorScheme
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            lampHeader()
            Spacer()
        }
        .ignoresSafeArea()
    }
    
    func lampHeader() -> some View {
        HStack {
            Spacer()
            VStack(spacing: 0) {
                Image(Images.lamp)
                    .resizable()
                    .frame(width: 100, height: 100)
                Triangle()
                    .frame(width: 350, height: 200, alignment: .center)
                    .foregroundStyle(
                        LinearGradient(colors: viewModel.lampColors(for: colorScheme),
                                       startPoint: .top,
                                       endPoint: .bottom)
                    )
                    .offset(y: -16)
            }
        }
        .offset(x: 80)
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel())
}

struct Triangle : Shape{
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.closeSubpath()
        }
    }
}
