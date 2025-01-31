//
//  FileManager+Extensions.swift
//  RecipeApp
//
//  Created by Scott Zhu on 1/24/25.
//


import Foundation

extension FileManager {
    func fileExists(at url: URL) -> Bool {
        fileExists(atPath: url.path)
    }
    
    func removeFileIfExists(at url: URL) throws {
        if fileExists(at: url) {
            try removeItem(at: url)
        }
    }
    
    func createDirectoryIfNeeded(at url: URL) throws {
        if !fileExists(at: url) {
            try createDirectory(at: url, withIntermediateDirectories: true)
        }
    }
}