//
//  ImageLoaderTests.swift
//  RecipeApp
//
//  Created by Scott Zhu on 1/24/25.
//


import XCTest
@testable import RecipeApp

final class ImageLoaderTests: XCTestCase {
    var imageLoader: ImageLoader!
    let testURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")!
    
    override func setUp() {
        super.setUp()
        imageLoader = ImageLoader()
        // Clear cache before each test
        try? FileManager.default.removeItem(at: imageLoader.cacheDirectory)
    }
    
    func testImageCaching() async {
        // First load - should download and cache
        let firstImage = await imageLoader.loadImage(from: testURL)
        XCTAssertNotNil(firstImage)
        
        // Second load - should load from cache
        let secondImage = await imageLoader.loadImage(from: testURL)
        XCTAssertNotNil(secondImage)
    }
    
    func testInvalidURL() async {
        let invalidURL = URL(string: "https://invalid.url")!
        let image = await imageLoader.loadImage(from: invalidURL)
        XCTAssertNil(image)
    }
    
    func testMemoryCache() async {
        // Load image
        let firstImage = await imageLoader.loadImage(from: testURL)
        XCTAssertNotNil(firstImage)
        
        // Remove from disk cache
        try? FileManager.default.removeItem(at: imageLoader.cacheDirectory)
        
        // Should still be in memory cache
        let secondImage = await imageLoader.loadImage(from: testURL)
        XCTAssertNotNil(secondImage)
    }
}
