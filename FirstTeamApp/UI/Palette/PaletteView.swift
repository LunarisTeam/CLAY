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
        VStack {
            HStack {
                Text("Palette")
                    .font(.title)
                    .padding()
            }

            Divider()
                .padding(.horizontal, 20)

            BrushTypeView(brushState: $brushState)
                .padding(.horizontal, 20)

            Spacer()
            
            Divider()
                .padding(.horizontal, 20)

            PresetBrushSelectorView(brushState: $brushState)
                .frame(minHeight: 125)
        }
        .padding(.vertical, 20)
    }
}
