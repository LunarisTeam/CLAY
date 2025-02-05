//
//  FirstTeamAppApp.swift
//  FirstTeamApp
//
//  Created by Davide Castaldi on 08/07/24.
//

import SwiftUI

@main
struct FirstTeamAppApp: App {
    @Environment(\.scenePhase) var scenePhase
    
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
    @State private var alertForDemo = !UserDefaults.standard.bool(forKey: "alert")
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    @MainActor private func setMode(_ newMode: Mode) async {
        let oldMode = mode
        mode = newMode
        
        if !immersiveSpacePresented && newMode.needsImmersiveSpace {
            
            immersiveSpacePresented = true
            await openImmersiveSpace(id: Self.immersiveSpaceWindowId)
            
        } else if immersiveSpacePresented && !newMode.needsImmersiveSpace {
            
            immersiveSpacePresented = false
            await dismissImmersiveSpace()
            
        }
        
        guard newMode != oldMode else { return }

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
                    .alert("Welcome to CLAY!", isPresented: $alertForDemo) {
                        Button("OK") {
                            UserDefaults.standard.set(true, forKey: "alert")
                            alertForDemo = false
                        }
                    } message: {
                        Text("⚠️ Warning ⚠️ \n Clay is a technical demo. All drawings made within the application are temporary and will be lost when you close the application or click 'Reset Canvas'.")
                    }
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
                        .overlay(alignment: .bottomTrailing) {
                            Button {
                                Task {
                                    await setMode(.chooseWorkVolume)
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "cube.transparent")
                                    Text("Reset canvas")
                                        .font(.headline)
                                }
                            }
                            
                            .padding(40)
                        }
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
                
                /// This modifier allows us to know if the ImmersiveSpace is still active.
                ///
                /// @brief
                ///    After pressing the Home Button the "new" value will have a nil amount, therefore we can let the rest of the app know
                ///    by updating immersiveSpacePresented, so that any future interaction will not break the navigation flow.
                .onImmersionChange() { _, new in
                    if new.amount == nil { immersiveSpacePresented = false }
                }
            }
            .immersionStyle(selection: $immersionStyle, in: .mixed)
            
            /// This modifier allows us to detect changes in the application scenePhase.
            ///
            /// @brief
            ///    When the app gets pushed to background, we let it know that the immersive space is not presented anymore.
            ///    If the user closes the main window, after returning from the Home Screen we can call "setMode" so that the correct
            ///    window will be displayed again. Doing this prevents the user from breaking the application flow, which leads to an unusable product.
            .onChange(of: scenePhase) { old, new in
                
                if new == .inactive || new == .background {
                    immersiveSpacePresented = false
                    
                } else if new == .active {
                    Task { await setMode(mode) }
                }
            }
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
