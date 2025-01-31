//
//  RecipeListView.swift
//  RecipeApp
//
//  Created by Scott Zhu on 1/24/25.
//

import SwiftUICore
import SwiftUI


struct RecipeListView: View {
    @StateObject var viewModel = RecipeListViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .idle, .loading:
                    LoadingView()
                case .loaded, .refreshing:
                    List(viewModel.recipes) { recipe in
                        RecipeRowView(recipe: recipe)
                    }
                case .error(let error):
                    ErrorView(error: error, retryAction: {
                        Task { await viewModel.loadRecipes() }
                    })
                case .empty:
                    EmptyView()
                }
            }
            .navigationTitle("Recipes")
            .refreshable {
                await viewModel.loadRecipes()
                print("refreshable")
            }
        }
        .task { await viewModel.loadRecipes() }
    }
}
