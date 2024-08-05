//
//  Array+Extensions.swift
//  SetCardGame
//
//  Created by Rachel Lee on 8/4/24.
//

import Foundation

extension Array where Element: Equatable {
    mutating func remove(_ element: Element) -> Element? {
        guard let indexOfElementToRemove = self.firstIndex(of: element) else { return nil }
        return self.remove(at: indexOfElementToRemove)
    }
}
