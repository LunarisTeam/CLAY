//
//  FirstTeamAppApp.swift
//  FirstTeamApp
//
//  Created by Davide Castaldi on 08/07/24.
//

import SwiftUI

let conversionFactorMetersToPixel: CGFloat = 1360

@main
struct FirstTeamAppApp: App {
    var body: some Scene {
        
//        @State var brushState = BrushState()
        
        //builds scenes. We need to give the id for the views, because we have to open and dismiss manually
        WindowGroup(id: "main") {
            DashboardView()
        }
        
//        WindowGroup(id: "palette") {
//            PaletteView(brushState: $brushState)
//                .frame(width: 400, height: 550, alignment: .top)
//                .fixedSize(horizontal: true, vertical: false)
//        }
//        .windowResizability(.contentSize)
        
        //builds immersive spaces, same concept as before
        ImmersiveSpace(id: "DrawingView") {
            DrawingView()
        }
    }
}

