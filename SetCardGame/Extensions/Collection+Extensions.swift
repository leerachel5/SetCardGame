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
    
    func allDifferent() -> Bool {
        guard self.count > 1 else {
            return true
        }
        for (i, element) in self.enumerated() {
            for j in (i + 1)..<self.count {
                if element == self[self.index(self.startIndex, offsetBy: j)] {
                    return false
                }
            }
        }
        return true
    }

}

