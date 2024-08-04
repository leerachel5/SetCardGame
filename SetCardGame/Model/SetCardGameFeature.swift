//
//  SetCardGameFeature.swift
//  SetCardGame
//
//  Created by Rachel Lee on 8/4/24.
//

import SwiftUI

protocol FeatureProtocol: Equatable, CaseIterable {}

struct SetCardGameFeature {
    protocol Number: FeatureProtocol {
        var rawValue: Int { get }
    }
    protocol Shape: FeatureProtocol {
        var insettableShape: AnyInsettableShape { get }
    }
    protocol Shading: FeatureProtocol {
        var opacity: Double { get }
    }
    protocol Color: FeatureProtocol {
        var swiftUIColor: SwiftUI.Color { get }
    }
}
