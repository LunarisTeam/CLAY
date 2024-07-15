//
//  DashboardView.swift
//  FirstTeamApp
//
//  Created by Giuseppe Rocco on 15/07/24.
//

import RealityKit
import SwiftUI

struct DashboardView: View {
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    
    var body: some View {
        ZStack {
                
            // Something goes here (backdrop maybe)
            
            VStack {
                Spacer(minLength: 100)
                
                // Something goes here (logo maybe)
                
                Spacer(minLength: 50)
                
                Button {
                    dismissWindow(id: "main")
                    openWindow(id: "palette")
                    
                    Task {
                        await openImmersiveSpace(id: "DrawingView")
                    }
                } label: {
                    Text("Start").frame(minWidth: 150)
                }
                .glassBackgroundEffect()
                .controlSize(.extraLarge)
                
                Spacer(minLength: 100)
            }
        }
    }
}

