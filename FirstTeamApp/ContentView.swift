//
//  ContentView.swift
//  FirstTeamApp
//
//  Created by Davide Castaldi on 08/07/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
        
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
    ContentView()
}
