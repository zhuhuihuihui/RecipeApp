import Foundation
import UIKit
import CryptoKit

class ImageLoader: ObservableObject {
    static let shared = ImageLoader()
    private let memoryCache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    var cacheDirectory: URL

    init() {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        cacheDirectory = paths[0].appendingPathComponent("ImageCache")

        #if DEBUG
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            let tempDirectory = FileManager.default.temporaryDirectory
            cacheDirectory = tempDirectory.appendingPathComponent("ImageCache")
        }
        #endif

        do {
            try fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
        } catch {
            print("Error creating cache directory: \(error)")
        }
    }

    func loadImage(from url: URL) async -> UIImage? {
        let cacheKey = self.sha256(url.absoluteString)

        // Check memory cache
        if let image = memoryCache.object(forKey: cacheKey as NSString) {
            return image
        }

        // Check disk cache
        let fileURL = cacheDirectory.appendingPathComponent(cacheKey)
        if let image = UIImage(contentsOfFile: fileURL.path) {
            memoryCache.setObject(image, forKey: cacheKey as NSString)
            return image
        }

        // Download image
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }

            // Ensure directory exists before writing
            if !fileManager.fileExists(atPath: cacheDirectory.path) {
                try fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
            }

            // Cache in memory and disk
            memoryCache.setObject(image, forKey: cacheKey as NSString)
            try data.write(to: fileURL)
            return image
        } catch {
            print("Image loading error: \(error)")
            return nil
        }
    }

    private func sha256(_ string: String) -> String {
        let data = Data(string.utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }
}
