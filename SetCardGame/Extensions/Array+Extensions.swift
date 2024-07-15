//
//  Array+Extensions.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/14/24.
//

import Foundation

extension Array where Iterator.Element: Equatable {
    func containsAllElements<S: Sequence>(in other: S) -> Bool where S.Element == Element {
        return other.allSatisfy(self.contains)
    }
    
    func allTheSame() -> Bool {
        self.allSatisfy({ $0 == self.first })
    }
}

extension Array where Iterator.Element: Hashable {
    func allDifferent() -> Bool {
        return self.count == Set(self).count
    }
}
