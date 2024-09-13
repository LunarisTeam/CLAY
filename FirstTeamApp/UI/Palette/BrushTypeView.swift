//
//  BrushTypeView.swift
//  FirstTeamApp
//
//  Created by Davide Castaldi on 23/07/24.
//

import SwiftUI
import RealityKit

private extension SolidBrushStyleProvider.ThicknessType {
    var viscosity: Float {
        get {
            switch self {
            case let .calligraphic(viscosity, _, _): return viscosity
            default: preconditionFailure("can only be called on calligraphic brush")
            }
        }
        
        set {
            switch self {
            case let .calligraphic(_, sensitivity, response):
                self = .calligraphic(viscosity: newValue, sensitivity: sensitivity, response: response)
            default: preconditionFailure("can only be called on calligraphic brush")
            }
        }
    }
    
    var sensitivity: Float {
        get {
            switch self {
            case let .calligraphic(_, sensitivity, _): return sensitivity
            default: preconditionFailure("can only be called on calligraphic brush")
            }
        }
        
        set {
            switch self {
            case let .calligraphic(viscosity, _, response):
                self = .calligraphic(viscosity: viscosity, sensitivity: newValue, response: response)
            default: preconditionFailure("can only be called on calligraphic brush")
            }
        }
    }
    
    var response: Float {
        get {
            switch self {
            case let .calligraphic(_, _, response): return response
            default: preconditionFailure("can only be called on calligraphic brush")
            }
        }
        
        set {
            switch self {
            case let .calligraphic(viscosity, sensitivity, _):
                self = .calligraphic(viscosity: viscosity, sensitivity: sensitivity, response: newValue)
            default: preconditionFailure("can only be called on calligraphic brush")
            }
        }
    }
}

struct SolidBrushStyleView: View {
    @Binding var settings: SolidBrushStyleProvider.Settings

    var body: some View {
        VStack(spacing: 20.0) {
            let colorBinding = Color.makeBinding(from: $settings.color)
            ColorPicker("Color", selection: colorBinding)
            
            HStack {
                Text("Roughness")
                Slider(value: $settings.roughness, in: 0...1)
                    .transaction { $0.animation = nil }
            }
            
            HStack {
                Text("Metallic")
                Slider(value: $settings.metallic, in: 0...1)
                    .transaction { $0.animation = nil }
            }
            
            HStack {
                Text("Thickness")
                Slider(value: $settings.thickness, in: 0.002...0.02)
                    .transaction { $0.animation = nil }
            }
            
            if case .calligraphic(_, _, _) = settings.thicknessType {
                HStack {
                    Text("Viscosity")
                    Slider(value: $settings.thicknessType.viscosity, in: 0.05...0.95)
                        .transaction { $0.animation = nil }
                }
                
                HStack {
                    Text("Speed Sensitivity")
                    Slider(value: $settings.thicknessType.sensitivity, in: 0.5...1.0)
                        .transaction { $0.animation = nil }
                }
                
                HStack {
                    Text("Speed Range")
                    Slider(value: $settings.thicknessType.response, in: 0.5...1.0)
                        .transaction { $0.animation = nil }
                }
            }
        }
    }
}

struct SparkleBrushStyleView: View {
    @Binding var settings: SparkleBrushStyleProvider.Settings

    var body: some View {
        VStack(spacing: 20.0) {
            ColorPicker("Color", selection: Color.makeBinding(from: $settings.color))
            
            HStack {
                Text("Thickness")
                Slider(value: $settings.initialSpeed, in: 0.005...0.02)
                    .transaction { $0.animation = nil }
            }
            
            HStack {
                Text("Particle Size")
                Slider(value: $settings.size, in: 0.000_15...0.000_35)
                    .transaction { $0.animation = nil }
            }
        }
    }
}

struct BrushTypeView: View {
    @Binding var brushState: BrushState
        
    @State var showPreview: Bool = true
    
    private func refresh() {
        Task {
            showPreview = false
            
            try! await Task.sleep(nanoseconds: 250_000_000)
            
            showPreview = true
        }
    }
    
    var body: some View {
        HStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 25)
                .fill(.ultraThickMaterial)
                .blendMode(.overlay)
                .overlay {
                    if showPreview {
                        PreviewBrushView(brushState: $brushState)
                            .scaleEffect(1.5)
                            .offset(x: 22.5, y: 22.5)
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 400)

            ZStack {
                switch brushState.brushType {
                case .calligraphic:
                    SolidBrushStyleView(settings: $brushState.calligraphicStyleSettings)
                        .id("BrushStyleView")
                case .uniform:
                    SolidBrushStyleView(settings: $brushState.uniformStyleSettings)
                        .id("BrushStyleView")
                case .sparkle:
                    SparkleBrushStyleView(settings: $brushState.sparkleStyleSettings)
                        .id("BrushStyleView")
                }
            }
            .padding()
            .animation(.easeInOut, value: brushState.brushType)
        }
        .onChange(of: brushState.brushType) { refresh() }
        .onChange(of: brushState.uniformStyleSettings) { refresh() }
        .onChange(of: brushState.sparkleStyleSettings) { refresh() }
        .onChange(of: brushState.calligraphicStyleSettings) { refresh() }
        .ornament(visibility: .visible, attachmentAnchor: .scene(.bottom), contentAlignment: .center) {
            ZStack {
                Capsule()
                    .fill(Color("BackgroundColor"))
                    .opacity(0.75)
                    .blendMode(.multiply)
                
                Picker("Brush Type", selection: $brushState.brushType) {
                    ForEach(BrushType.allCases) { Text($0.label).tag($0) }
                }
                .pickerStyle(.segmented)
                .padding(5)
            }
        }
    }
}
