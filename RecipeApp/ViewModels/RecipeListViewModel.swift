//
//  RecipeListViewModel.swift
//  RecipeApp
//
//  Created by Scott Zhu on 1/24/25.
//

import Foundation

@MainActor
class RecipeListViewModel: ObservableObject {
    enum State: Equatable {
        case idle
        case loading
        case refreshing
        case loaded([Recipe])
        case error(Error)
        case empty

        static func == (lhs: RecipeListViewModel.State, rhs: RecipeListViewModel.State) -> Bool {
            switch (lhs, rhs) {
            case (.idle, .idle), (.loading, .loading), (.refreshing, .refreshing), (.loaded, .loaded), (.error, .error), (.empty, .empty):
                return true
            default:
                return false
            }
        }
    }
    
    @Published private(set) var state: State = .idle
    private(set) var recipes: [Recipe] = []
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func loadRecipes() async {
        state = state == .idle ? .loading : .refreshing
        do {
            let recipes = try await networkService.fetchRecipes()
            if recipes.isEmpty {
                self.recipes = []
                state = .empty
            } else {
                self.recipes = recipes
                state = .loaded(recipes)
            }
        } catch {
            self.recipes = []
            state = .error(error)
        }
    }

}
