//
//  LampAndLightView.swift
//  Swag
//
//  Created by Kazim Ahmad on 08/01/2026.
//

import SwiftUI

struct LampAndLightView: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        GeometryReader { geo in
        VStack {
                lightHeader()
                .offset(x: (geo.size.width / 2) - 100)
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
        .ignoresSafeArea()
    }
        
    func lightHeader() -> some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.clear)
                .frame(width: 100, height: 100, alignment: .center)
            Triangle()
                .frame(width: 350, height: 200, alignment: .center)
                .foregroundStyle(
                    LinearGradient(colors: lampColors(),
                                   startPoint: .top,
                                   endPoint: .bottom)
                )
                .offset(y: -16)
            Spacer()
        }
        .overlay {
            lampHeader()
        }
    }
    
    func lampColors() -> [Color] {
        if colorScheme == .dark {
            return [.lampLight,
                    .lampLight.opacity(0.8),
                    .lampLight.opacity(0.6),
                    .lampLight.opacity(0.4),
                    .lampLight.opacity(0.2),
                    .lampLight.opacity(0.1),
                    .lampLight.opacity(0.0)]
        }
        return []
    }
    
    func lampHeader() -> some View {
        VStack(spacing: 0) {
            Image(Images.lamp)
                .resizable()
                .frame(width: 100, height: 100)
            Spacer()
        }
    }
}

#Preview {
    LampAndLightView()
}
