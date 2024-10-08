//
//  FirstTeamAppApp.swift
//  FirstTeamApp
//
//  Created by Davide Castaldi on 08/07/24.
//

import SwiftUI

@main
struct FirstTeamAppApp: App {
    private static let paletteWindowId: String = "Palette"
    private static let configureCanvasWindowId: String = "ConfigureCanvas"
    private static let splashScreenWindowId: String = "SplashScreen"
    private static let immersiveSpaceWindowId: String = "ImmersiveSpace"
    
    /// The mode of the app determines which windows and immersive spaces should be open.
    enum Mode: Equatable {
        case splashScreen
        case chooseWorkVolume
        case drawing
        
        var needsImmersiveSpace: Bool {
            return self != .splashScreen
        }
        
        var needsSpatialTracking: Bool {
            return self != .splashScreen
        }
        
        fileprivate var windowId: String {
            switch self {
            case .splashScreen: return splashScreenWindowId
            case .chooseWorkVolume: return configureCanvasWindowId
            case .drawing: return paletteWindowId
            }
        }
    }
    
    @State private var mode: Mode = .splashScreen
    @State private var canvas = DrawingCanvasSettings()
    @State private var brushState = BrushState()
    
    @State private var immersiveSpacePresented: Bool = false
    @State private var immersionStyle: ImmersionStyle = .mixed
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    @MainActor private func setMode(_ newMode: Mode) async {
        let oldMode = mode
        guard newMode != oldMode else { return }
        mode = newMode
        
        if !immersiveSpacePresented && newMode.needsImmersiveSpace {
            immersiveSpacePresented = true
            await openImmersiveSpace(id: Self.immersiveSpaceWindowId)
        } else if immersiveSpacePresented && !newMode.needsImmersiveSpace {
            immersiveSpacePresented = false
            await dismissImmersiveSpace()
        }
        
        openWindow(id: newMode.windowId)
        dismissWindow(id: oldMode.windowId)
    }
    
    var body: some Scene {
        Group {
            WindowGroup(id: Self.splashScreenWindowId) {
                DashboardView()
                    .environment(\.setMode, setMode)
                    .frame(width: 1000, height: 800)
                    .fixedSize()
            }
            .windowResizability(.contentSize)
            .windowStyle(.plain)
            
            WindowGroup(id: Self.configureCanvasWindowId) {
                DrawingCanvasConfigurationView(settings: canvas)
                    .environment(\.setMode, setMode)
                    .fixedSize()
            }
            .windowResizability(.contentSize)
            
            WindowGroup(id: Self.paletteWindowId) {
                ZStack {
                    PaletteView(brushState: $brushState)
                        .frame(width: 900, height: 500, alignment: .center)
                        .fixedSize(horizontal: true, vertical: false)
                        .environment(\.setMode, setMode)
                }
            }
            .windowResizability(.contentSize)
            
            ImmersiveSpace(id: Self.immersiveSpaceWindowId) {
                ZStack {
                    if mode == .chooseWorkVolume || mode == .drawing {
                        DrawingCanvasVisualizationView(settings: canvas)
                    }
                    
                    if mode == .chooseWorkVolume {
                        DrawingCanvasPlacementView(settings: canvas)
                    } else if mode == .drawing {
                        DrawingMeshView(canvas: canvas, brushState: $brushState)
                    }
                }
                .frame(width: 0, height: 0).frame(depth: 0)
            }
            .immersionStyle(selection: $immersionStyle, in: .mixed)
        }
    }
}

struct SetModeKey: EnvironmentKey {
    typealias Value = (FirstTeamAppApp.Mode) async -> Void
    static let defaultValue: Value = { _ in }
}

extension EnvironmentValues {
    var setMode: SetModeKey.Value {
        get { self[SetModeKey.self] }
        set { self[SetModeKey.self] = newValue }
    }
}
