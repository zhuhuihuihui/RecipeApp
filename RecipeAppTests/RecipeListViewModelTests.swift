//
//  RecipeListViewModelTests.swift
//  RecipeApp
//
//  Created by Scott Zhu on 1/24/25.
//


import XCTest
@testable import RecipeApp

@MainActor
final class RecipeListViewModelTests: XCTestCase {
    var viewModel: RecipeListViewModel!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        viewModel = RecipeListViewModel(networkService: mockNetworkService)
    }
    
    func testInitialState() {
        XCTAssertEqual(viewModel.state, .idle)
    }
    
    func testSuccessfulLoad() async {
        await viewModel.loadRecipes()
        
        if case .loaded(let recipes) = viewModel.state {
            XCTAssertEqual(recipes.count, 4)
        } else {
            XCTFail("Expected loaded state")
        }
    }
    
    func testEmptyState() async {
        mockNetworkService.mockFile = "empty"

        await viewModel.loadRecipes()
        
        if case .empty = viewModel.state {
            // Success
        } else {
            XCTFail("Expected empty state")
        }
    }
    
    func testErrorState() async {
        mockNetworkService.shouldThrowError = true
        
        await viewModel.loadRecipes()
        
        if case .error = viewModel.state {
            // Success
        } else {
            XCTFail("Expected error state")
        }
    }
}

class MockNetworkService: NetworkServiceProtocol {
    var shouldThrowError = false
    var mockFile = "mock"

    func fetchRecipes() async throws -> [Recipe] {
        if shouldThrowError {
            throw NSError(domain: "test", code: 0)
        }

        guard let url = Bundle(for: type(of: self)).url(forResource: mockFile, withExtension: "json") else {
            throw NSError(domain: "MockNetworkService", code: 1, userInfo: [NSLocalizedDescriptionKey: "mock file not found"])
        }

        let data = try Data(contentsOf: url)
        let response = try JSONDecoder().decode(RecipeResponse.self, from: data)

        return response.recipes
    }
}
