//
//  FontQuicksand.swift
//  FirstTeamApp
//
//  Created by Giuseppe Rocco on 18/09/24.
//

import SwiftUI

enum QuicksandTypes {
    case regular
    case bold
    case thin
    case medium
    case semibold
    
    func fontName() -> String {
        switch self {
        case .bold:
            return "Quicksand-Bold"
        case .medium:
            return "Quicksand-Medium"
        case .regular:
            return "Quicksand-Regular"
        case .semibold:
            return "Quicksand-Semibold"
        case .thin:
            return "Quicksand-Thin"
        }
    }
}

private struct FontQuicksand: ViewModifier {
    
    let type: QuicksandTypes
    let size: CGFloat
    
    func body(content: Content) -> some View {
        return content
            .font(Font.custom(type.fontName(), size: size))
    }
}

extension View {
    
    @MainActor func fontQuicksand(_ type: QuicksandTypes, _ size: CGFloat) -> some View {
        return self
            .modifier(FontQuicksand(type: type, size: size))
    }
}
