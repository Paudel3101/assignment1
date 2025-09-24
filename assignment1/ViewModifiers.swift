//
//  ViewModifiers.swift
//  assignment1
//
//  Created by Bishal Paudel on 9/24/25.
//

import SwiftUI

// MARK: - Large Title Modifier
struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 34, weight: .bold, design: .rounded))
            .foregroundColor(Color.accentColor)
    }
}

// MARK: - Card Modifier
struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 4))
    }
}

