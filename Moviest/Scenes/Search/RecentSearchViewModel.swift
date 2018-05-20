//
//  RecentSearchViewModel.swift
//  Moviest
//
//  Created by Bilal Arslan on 20.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import Foundation
import UIKit

class RecentSearchViewModel: NSObject {

    var selectionHandler: ((String) -> Void)?
    let recentSearchesManager = RecentSearchesManager()

}

extension RecentSearchViewModel: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchesCell.defaultReuseIdentifier,
                                                 for: indexPath) as! RecentSearchesCell
        cell.searchLabel.text = recentSearchesManager.recentSearches[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearchesManager.recentSearches.count
    }

}

extension RecentSearchViewModel: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let query = recentSearchesManager.recentSearches[indexPath.row]
        selectionHandler?(query)
    }

}
