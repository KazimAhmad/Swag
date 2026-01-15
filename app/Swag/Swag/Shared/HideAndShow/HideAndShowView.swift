//
//  HideAndShowView.swift
//  Swag
//
//  Created by Kazim Ahmad on 08/01/2026.
//

import SwiftUI

enum HideAndShowState {
    case hidden
    case shown
}

struct HideAndShowView: View {
    @StateObject var viewModel: HideAndShowViewModel
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .hidden:
                hiddenAnimation()
            case .shown:
                shownAnimation()
            }
        }
        .onAppear() {
            withAnimation {
                viewModel.showDetail.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        viewModel.showDetail.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            viewModel.dismiss()
                        }
                    }
                }
            }
        }
    }
    
    func shownAnimation() -> some View {
        VStack {
            Image(Images.show)
                .resizable()
                .frame(width: viewModel.showDetail ? 100 : 0,
                       height: viewModel.showDetail ? 100 : 0)
                .scaleEffect(viewModel.showDetail ? 2 : 1)
                .padding()
                .animation(.bouncy, value: viewModel.showDetail)
        }
    }
    
    func hiddenAnimation() -> some View {
        VStack {
            Image(Images.hide)
                .resizable()
                .frame(width: 100,
                       height: 100)
                .scaleEffect(viewModel.showDetail ? 2 : 1)
                .animation(.bouncy, value: viewModel.showDetail)
                .offset(x: viewModel.showDetail ? 0 : 300)
        }
    }
}

#Preview {
    HideAndShowView(viewModel: HideAndShowViewModel(state: .hidden, coordinator: OnboardingCoordiantor()))
}
