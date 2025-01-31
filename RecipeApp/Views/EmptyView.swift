//
//  EmptyView.swift
//  RecipeApp
//
//  Created by Scott Zhu on 1/24/25.
//


import SwiftUI

struct EmptyView: View {
    var body: some View {
        List {
            GeometryReader { geometry in
                VStack(spacing: 16) {
                    Image(systemName: "fork.knife")
                        .font(.system(size: 48))
                        .foregroundColor(.secondary)

                    Text("No Recipes Found")
                        .font(.headline)

                    Text("It seems there are no recipes available at the moment.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Center within GeometryReader
            }
            .frame(height: 400) // Adjust height to push content to center
        }
        .listStyle(.plain)
    }
}
