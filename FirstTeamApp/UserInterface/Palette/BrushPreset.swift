//
//  BrushPreset.swift
//  FirstTeamApp
//
//  Created by Giuseppe Rocco on 15/07/24.
//

//import SwiftUI
//
//enum BrushPreset: Equatable {
//    case solid(settings: SolidBrush.Settings)
//    case sparkle(settings: SparkleBrush.Settings)
//}
//
//enum BrushType: Hashable, Equatable, CaseIterable, Identifiable {
//    case uniform
//    case sparkle
//    
//    var id: Self { return self }
//    
//    var label: String {
//        switch self {
//        case .uniform: return "Uniform"
//        case .sparkle: return "Sparkle"
//        }
//    }
//}
//
//@Observable
//class BrushState {
//    var brushType: BrushType = .uniform
//    var uniformStyleSettings = SolidBrush.Settings()
//    var sparkleStyleSettings = SparkleBrush.Settings()
//    
//    init() {}
//    
//    init(preset: BrushPreset) { apply(preset: preset) }
//    
//    var asPreset: BrushPreset {
//        switch brushType {
//        case .uniform: .solid(settings: uniformStyleSettings)
//        case .sparkle: .sparkle(settings: sparkleStyleSettings)
//        }
//    }
//    
//    func apply(preset: BrushPreset) {
//        switch preset {
//        case let .solid(settings):
//            brushType = .uniform
//            uniformStyleSettings = settings
//        case let .sparkle(settings):
//            brushType = .sparkle
//            sparkleStyleSettings = settings
//        }
//    }
//}
