//
//  RecipeRowView.swift
//  RecipeApp
//
//  Created by Scott Zhu on 1/24/25.
//

import SwiftUICore
import UIKit
import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe
    @State private var image: UIImage?
    
    var body: some View {
        HStack(spacing: 16) {
            recipeImage
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .task { await loadImage() }
    }
    
    @ViewBuilder
    private var recipeImage: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .cornerRadius(8)
        } else {
            ProgressView()
                .frame(width: 60, height: 60)
        }
    }
    
    private func loadImage() async {
        guard let url = recipe.photoURLSmall else { return }
        image = await ImageLoader.shared.loadImage(from: url)
    }
}
