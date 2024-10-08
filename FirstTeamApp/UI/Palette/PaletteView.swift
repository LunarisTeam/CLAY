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
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                    .opacity(0.5)
                    .blendMode(.multiply)
                
                VStack(alignment: .leading) {
                    
                    Button {
                        print("Button tapped")
                        Task {
                            await setMode(.chooseWorkVolume)
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    
                    .padding(.horizontal, 2.5)
                    .padding(.vertical, 5)
                                        
                    BrushTypeView(brushState: $brushState)
                }
                .environment(\.setMode, setMode)
                .padding()
                
            }
        }
    }
}
