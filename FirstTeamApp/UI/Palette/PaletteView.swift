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
    @Binding var brushState: BrushState

    @State var isDrawing: Bool = false
    @State var isSettingsPopoverPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                    .opacity(0.5)
                    .blendMode(.multiply)
                
                VStack {
                    
                    
                    
                    
                    BrushTypeView(brushState: $brushState)
                        .padding(.horizontal, 20)
                    
                }
                .padding(.vertical, 20)
            }
        }
    }
}
