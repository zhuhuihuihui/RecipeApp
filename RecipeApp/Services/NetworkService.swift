//
//  NetworkServiceProtocol.swift
//  RecipeApp
//
//  Created by Scott Zhu on 1/24/25.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchRecipes() async throws -> [Recipe]
}

class NetworkService: NetworkServiceProtocol {
    private let baseURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
    
    func fetchRecipes() async throws -> [Recipe] {
        var request = URLRequest(url: baseURL)
        request.cachePolicy = .reloadIgnoringLocalCacheData  // Ignore any local cache
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(RecipeResponse.self, from: data)
        return response.recipes
    }
}
