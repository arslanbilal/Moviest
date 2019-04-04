//
//  RecentSearchesManager.swift
//  Moviest
//
//  Created by Bilal Arslan on 20.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import Foundation

class RecentSearchesManager {

    private enum Const {
        static let numberOfItemsToKeep: Int = 10
    }

    /**
     File path to the file that recent searches will be persisted.
     */
    private var filePath: String = {
        let fileManager = FileManager.default
        guard let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            fatalError("Caches directory not available.")
        }
        let fileURL = cachesDirectory.appendingPathComponent("recent_searches")
        return fileURL.path
    }()

    private(set) var recentSearches: [String]

    init() {
        if let recentSearches = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [String] {
            self.recentSearches = recentSearches
        } else {
            self.recentSearches = [] // Assign an empty array as we don't have any recent search yet.
        }
    }

    func addSearchQuery(_ query: String) {
        // If already present remove it, it will be added to top again
        if let index = recentSearches.firstIndex(of: query) {
            recentSearches.remove(at: index)
        }
        // Insert the new query to top
        recentSearches.insert(query, at: 0)
        // Remove the oldest search if we exceed the cap
        if recentSearches.count > Const.numberOfItemsToKeep {
            recentSearches.removeLast()
        }
        // Write the updated list to file.
        NSKeyedArchiver.archiveRootObject(recentSearches, toFile: filePath)
    }

    func clearrecentSearches() {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: filePath)
        } catch {
            // File not available.
        }
    }

}
