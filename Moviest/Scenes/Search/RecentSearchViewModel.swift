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

}

extension RecentSearchViewModel: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchesCell.defaultReuseIdentifier,
                                                 for: indexPath) as! RecentSearchesCell
        cell.searchLabel.text = "Batman \(indexPath.row + 1)"
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

}

extension RecentSearchViewModel: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionHandler?("Batman")
    }

}
