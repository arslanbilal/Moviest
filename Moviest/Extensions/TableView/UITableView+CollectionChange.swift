//
//  UITableView+CollectionChange.swift
//  Moviest
//
//  Created by Bilal Arslan on 19/05/2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import UIKit

extension UITableView {
    
    func applyCollectionChange(_ change: CollectionChange, toSection section: Int, withAnimation animation: UITableViewRowAnimation) {
        func makeIndexPath(using index: Int) -> IndexPath {
            return IndexPath(row: index, section: section)
        }
        
        func makeIndexPaths(using indexSet: IndexSet) -> [IndexPath] {
            return indexSet.map { makeIndexPath(using: $0) }
        }
        
        switch change {
        case .update(let indexes):
            reloadRows(at: makeIndexPaths(using: indexes.toIndexSet()), with: animation)
        case .insertion(let indexes):
            insertRows(at: makeIndexPaths(using: indexes.toIndexSet()), with: animation)
        case .deletion(let indexes):
            deleteRows(at: makeIndexPaths(using: indexes.toIndexSet()), with: animation)
        case .move(let from, let to):
            moveRow(at: makeIndexPath(using: from), to: makeIndexPath(using: to))
        case .reload:
            reloadData()
        }
    }
}
