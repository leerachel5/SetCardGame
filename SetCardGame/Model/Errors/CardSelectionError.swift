//
//  CardSelectionError.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/14/24.
//

import Foundation

enum CardSelectionError: Error {
    case selectedCardNotFaceUp
}

extension CardSelectionError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .selectedCardNotFaceUp:
            return NSLocalizedString("Cannot match set with non-face-up cards.", comment: "Selected card is not face up")
        }
    }
}
