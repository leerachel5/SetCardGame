//
//  Array+Extensions.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/14/24.
//

import Foundation

extension Array where Iterator.Element: Equatable {
    func containsAllElements(in other: Array) -> Bool {
        return other.allSatisfy(self.contains)
    }
}

extension Array where Iterator.Element: Hashable {
    func allTheSame() -> Bool {
        self.allSatisfy({ $0 == self.first })
    }
    
    func allDifferent() -> Bool {
        return self.count == Set(self).count
    }
}
