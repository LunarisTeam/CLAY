//
//  DashboardView.swift
//  FirstTeamApp
//
//  Created by Giuseppe Rocco on 15/07/24.
//

import RealityKit
import SwiftUI

struct DashboardView: View {
    
    private static let startButtonWidth: CGFloat = 150
    
    @Environment(\.setMode) var setMode
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
                .fontQuicksand(.regular, 100)
                .foregroundColor(Color.white)
                .kerning(60)
                .shadow(radius: 4)
                .padding(.leading, 270)
                .padding(.bottom, 100)

                
            
            Image("BgText")
                .resizable()
                .frame(width: 630, height: 90)
                .padding(.top, 160)
                
            
            Text("Shape Art\n and your surroundings")
                .fontQuicksand(.regular, 28)
                .fontWeight(.light)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
                .shadow(radius: 4)
                .padding(.top, 150)
            
            VStack {
                Spacer(minLength: 400)
                
                
                
                Spacer(minLength: 50)
                
                Button {
                    Task {
                        await setMode(.chooseWorkVolume)
                    }
                } label: {
                    Text("Start")
                        .frame(minWidth: Self.startButtonWidth)
                }
                .glassBackgroundEffect()
                .controlSize(.extraLarge)
                .frame(width: Self.startButtonWidth)
                
                Spacer(minLength: 100)
            }
            .frame(depth: 0, alignment: DepthAlignment.back)
        }
    }
}

#Preview {
    DashboardView()
}
