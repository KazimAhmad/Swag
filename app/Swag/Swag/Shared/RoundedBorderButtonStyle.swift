//
//  RoundedButtonStyle.swift
//  Swag
//
//  Created by Kazim Ahmad on 08/01/2026.
//

import SwiftUI

struct RoundedBorderButtonStyle: ButtonStyle {
    var backgroundColor: Color = .darkPurple
    var borderColor: Color = .darkPurple
    var textColor: Color = .white
    
    var cornerRadius: CGFloat = 12
    var borderWidth: CGFloat = 1

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 16)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .background(
                backgroundColor
                    .opacity(configuration.isPressed ? 0.85 : 1)
            )
            .foregroundColor(textColor)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}
