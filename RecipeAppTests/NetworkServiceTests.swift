//
//  NetworkServiceTests.swift
//  RecipeApp
//
//  Created by Scott Zhu on 1/24/25.
//
import XCTest
@testable import RecipeApp

class NetworkServiceTests: XCTestCase {
    func testSuccessfulRecipeFetch() async throws {
        let mockService = MockNetworkService()
        let viewModel = await RecipeListViewModel(networkService: mockService)
        
        await viewModel.loadRecipes()
        
        if case .loaded(let recipes) = await viewModel.state {
            XCTAssertEqual(recipes.count, 4)
        } else {
            XCTFail("Expected loaded state")
        }
    }
}
