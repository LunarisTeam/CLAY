//
//  SplashScreenView.swift
//  FirstTeamApp
//
//  Created by Davide Castaldi on 23/07/24.
//

import RealityKit
import SwiftUI

struct SplashScreenView: View {
    private static let startButtonWidth: CGFloat = 150
    
    @Environment(\.setMode) var setMode
    
    var body: some View {
        ZStack {
            DashboardView()
            
            VStack {
                Spacer(minLength: 400)
                
                
                
                Spacer(minLength: 50)
                
                Button {
                    Task {
                        await setMode(.chooseWorkVolume)
                    }
                } label: {
                    Text("Start").frame(minWidth: Self.startButtonWidth)
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
