//
//  DrawingCanvasConfigurationView.swift
//  FirstTeamApp
//
//  Created by Davide Castaldi on 23/07/24.
//

import SwiftUI
import RealityKit

/// A view that contains configurations for the size of a drawing canvas.
///
/// This view should be used in a window.
///
/// It allows a person to configure the size of their drawing canvas, and also has a "Reset Placement"
/// button that brings the selected canvas location back to the location of the window.
struct DrawingCanvasConfigurationView: View {
    @Bindable var settings: DrawingCanvasSettings
    
    @MainActor @State var placementResetPose: Entity?
    
    @Environment(\.setMode) var setMode
    @Environment(\.physicalMetrics) var physicalMetrics
    
    private let resetPose = Entity()
    
    /// Resets the position of the placement entity.
    ///
    /// The ``DrawingCanvasSettings/placementEntity`` should be in the immersive space,
    /// to be coincident with ``placementResetPose``, which is positioned relative to the window.
    ///
    /// - Parameters:
    ///   - duration: The time in seconds of the animation takes to move `placementEntity`.
    private func resetPlacement(duration: TimeInterval = 0.2) {
        if let resetPoseMatrix = placementResetPose?.transformMatrix(relativeTo: .immersiveSpace) {
            var transform = Transform(matrix: resetPoseMatrix)
            transform.scale = .one
            settings.placementEntity.move(to: transform, relativeTo: nil, duration: duration)
            settings.placementEntity.isEnabled = true
        }
    }
    
    /// A Boolean value that determines whether the canvas placement handle is locked to the location of this view.
    ///
    /// If `true`, the canvas placement handle is locked.
    private var isPlacementLockedToWindow: Bool {
        if !settings.placementEntity.isEnabled {
            return true
        } else if let component = settings.placementEntity.components[DrawingCanvasPlacementComponent.self] {
            return component.lockedToWindow
        }
        return false
    }
    
    var body: some View {
        
        ZStack{
            Color("BackgroundColor")
                .ignoresSafeArea()
                .opacity(0.5)
                .blendMode(.multiply)
            
            VStack {
                
                
                
                Image("LogoSetUp")
                    .resizable()
                
                    .frame(width: 52, height: 52)
                
                    .padding()
                
                
                VStack(spacing: 1) {
                    Text("Set up your canvas")
                    
                        .font(.system(size: 20, weight: .bold))
                    
                    
                    Text("Set up the space that you will use to create your masterpiece")
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.system(size: 18, weight: .thin))
                    
                }
                
                // This `RealityView` contains no visible entities.
                // Its purpose is to hold `placementRestPose`, so that
                // when a person taps "Reset Placement" the app knows where to move `placementEntity` back to.
                RealityView { content in
                    resetPose.position.x = 0.2
                    content.add(resetPose)
                    
                    placementResetPose = resetPose
                    settings.placementEntity.isEnabled = false
                    
                    resetPlacement()
                } update: { content in
                    if isPlacementLockedToWindow {
                        resetPlacement()
                    }
                }
                .task {
                    try? await Task.sleep(for: .seconds(0.5))
                    if isPlacementLockedToWindow {
                        resetPlacement()
                    }
                }
                .frame(depth: 0).frame(width: 0, height: 0)
                
                Divider()
                
                VStack(spacing: 1){
                HStack {
                    Text("Size")
                        .padding()
                    Slider(value: $settings.radius, in: 0.5...2.0)
                }
                .padding(.top)
                
                
                
                    Button("Reset Placement") {
                        resetPlacement()
                    }
                    .buttonStyle(.plain)
                    
                    .padding()
                    
                    Button("Start Drawing") {
                        Task { await setMode(.drawing) }
                    }
                }
               
                
            }
            .padding(20)
            .frame(width: 320, height: 380)
        }
    }
}

