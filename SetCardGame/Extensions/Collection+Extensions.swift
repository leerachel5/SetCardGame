//
//  Collection+Extensions.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/15/24.
//

import Foundation

extension Collection where Element: Equatable {
    func containsAllElements<S: Sequence>(in sequence: S) -> Bool where S.Element == Element {
        for element in sequence {
            if !self.contains(element) {
                return false
            }
        }
        return true
    }
    
    func allTheSame() -> Bool {
        self.allSatisfy({ $0 == self.first })
    }
}

extension Collection where Iterator.Element: Hashable {
    func allDifferent() -> Bool {
        return self.count == Set(self).count
    }
}

