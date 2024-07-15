//
//  MenuView.swift
//  FirstTeamApp
//
//  Created by Alessandro Ricci on 15/07/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct MenuView: View {
        
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    @Environment(\.dismissWindow) var dismissWindow

    var body: some View {
        VStack {

            Text("Welcome to the drawing app!")
                .font(.extraLargeTitle)

            Button {
                Task {
                    
                    dismissWindow(id: "main")
                    await openImmersiveSpace(id: "DrawingView")
                }
            } label: {
                Text("Show Drawing View")
                    .font(.title)
                    .frame(width: 360)
                    .padding(24)
                    .glassBackgroundEffect()
            }
        }
        
        .onDisappear {
            dismissWindow(id: "main")
        }
        
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    MenuView()
}
