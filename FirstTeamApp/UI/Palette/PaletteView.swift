//
//  PaletteView.swift
//  FirstTeamApp
//
//  Created by Davide Castaldi on 23/07/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct PaletteView: View {
    
    @Environment(\.setMode) var setMode
    @Binding var brushState: BrushState
    
    @State var isDrawing: Bool = false
    @State var isSettingsPopoverPresented: Bool = false
    
    var body: some View {
        NavigationStack {            
            BrushTypeView(brushState: $brushState)
        }
    }
}
