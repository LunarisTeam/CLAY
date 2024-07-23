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
            
            Image("WelcomeImage")
                .resizable()
                .frame(width: 950)
            
            Image("Clogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 240)
                .padding(.trailing, 300)
                .padding(.bottom, 100)
                .shadow(radius: 20)
                
            
            Text("LAY")
                .font(.system(size: 100, weight: .thin, design: .rounded))
                .fontWeight(.thin)
                .foregroundColor(Color.black)
                .kerning(60)
                .padding(.leading, 270)
                .padding(.bottom, 100)
            
            Text("Spatial Drawing\nfor VisionOs")
                .font(.system(size: 34, weight: .thin, design: .rounded))
                .fontWeight(.light)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
                .padding(.top, 150)
                
            
            VStack {
                Spacer(minLength: 500)
                
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
                
                .shadow( radius: 20)
                .opacity(1)
                .glassBackgroundEffect()
                .controlSize(.extraLarge)
                
                Spacer(minLength: 100)
            }
            
        }
    }
}

#Preview {
    DashboardView()
}
