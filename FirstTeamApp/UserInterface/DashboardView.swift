//
//  DashboardView.swift
//  FirstTeamApp
//
//  Created by Giuseppe Rocco on 15/07/24.
//

import RealityKit
import SwiftUI

struct DashboardView: View {
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
                .font(.system(size: 100, weight: .thin, design: .rounded))
                .fontWeight(.thin)
                .foregroundColor(Color.white)
                .kerning(60)
                .shadow(radius: 4)
                .padding(.leading, 270)
                .padding(.bottom, 100)
            
            Text("Shape Art\n and your surroundings")
                .font(.system(size: 28, weight: .thin, design: .rounded))
                .fontWeight(.light)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
                .shadow(radius: 4)
                .padding(.top, 150)
                
            
//            VStack {
//                Spacer(minLength: 500)
//                
//                // Something goes here (logo maybe)
//                
//                Spacer(minLength: 50)
//                
//                Button {
//                    
//                    Task {
//                        await setMode(.chooseWorkVolume)
//                    }
//                    
//                } label: {
//                    Text("Start").frame(minWidth: 150)
//                }
//                
//                .shadow( radius: 20)
//                .opacity(1)
//                .glassBackgroundEffect()
//                .controlSize(.extraLarge)
//                
//                Spacer(minLength: 100)
//            }
            
        }
    }
}

#Preview {
    DashboardView()
}
