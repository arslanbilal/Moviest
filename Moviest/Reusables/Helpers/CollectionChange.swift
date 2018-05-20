//
//  CollectionChange.swift
//  Premier
//
//  Created by Ilter Cengiz on 19/02/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import Foundation

protocol IndexSetConvertible {
    func toIndexSet() -> IndexSet
}

extension Int: IndexSetConvertible {
    func toIndexSet() -> IndexSet {
        return IndexSet(integer: self)
    }
}

extension UInt: IndexSetConvertible {
    func toIndexSet() -> IndexSet {
        return IndexSet(integer: Int(self))
    }
}

extension IndexSet: IndexSetConvertible {
    func toIndexSet() -> IndexSet {
        return self
    }
}

enum CollectionChange: Equatable {
    case reload
    case update(IndexSetConvertible)
    case insertion(IndexSetConvertible)
    case deletion(IndexSetConvertible)
    case move(from: Int, to: Int)
}

func ==(lhs: CollectionChange, rhs: CollectionChange) -> Bool {
    switch (lhs, rhs) {
    case (.reload, .reload):
        return true
    case (.insertion(let indexes1), .insertion(let indexes2)):
        return indexes1.toIndexSet() == indexes2.toIndexSet()
    case (.deletion(let indexes1), .deletion(let indexes2)):
        return indexes1.toIndexSet() == indexes2.toIndexSet()
    case (.update(let indexes1), .update(let indexes2)):
        return indexes1.toIndexSet() == indexes2.toIndexSet()
    case (.move(let from1, let to1), .move(let from2, let to2)):
        return (from1, to1) == (from2, to2)
    default:
        return false
    }
}
