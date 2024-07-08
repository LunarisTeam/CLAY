//
//  FirstTeamAppApp.swift
//  FirstTeamApp
//
//  Created by Davide Castaldi on 08/07/24.
//

import SwiftUI

@main
struct FirstTeamAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
