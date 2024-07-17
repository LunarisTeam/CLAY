//
//  PaletteView.swift
//  FirstTeamApp
//
//  Created by Giuseppe Rocco on 15/07/24.
//

//import SwiftUI
//import RealityKit
//import RealityKitContent
//
//struct PaletteView: View {
//    
//    @Binding var brushState: BrushState
//
//    @State var isDrawing: Bool = false
//    @State var isSettingsPopoverPresented: Bool = false
//
//    var body: some View {
//        VStack {
//            HStack {
//                Text("Palette")
//                    .font(.title)
//                    .padding()
//            }
//
//            Divider()
//                .padding(.horizontal, 20)
//            
//            Picker("Brush Type", selection: $brushState.brushType) {
//                ForEach(BrushType.allCases) { Text($0.label).tag($0) }
//            }
//            .pickerStyle(.segmented)
//            .padding(.horizontal, 20)
//            
//            Divider()
//                .padding(.horizontal, 20)
//
//            ScrollView(.vertical) {
//                ZStack {
//                    switch brushState.brushType {
//                    case .uniform:
//                        SolidBrushView(settings: $brushState.uniformStyleSettings)
//                            .id("BrushStyleView")
//                    case .sparkle:
//                        SparkleBrushView(settings: $brushState.sparkleStyleSettings)
//                            .id("BrushStyleView")
//                    }
//                }
//                .animation(.easeInOut, value: brushState.brushType)
//            }
//            .padding(.horizontal, 20)
//
//        }
//        .padding(.vertical, 20)
//    }
//}
//
//extension PaletteView {
//    private struct SolidBrushView: View {
//        
//        @Binding var settings: SolidBrush.Settings
//        
//        var body: some View {
//            VStack {
//                let colorBinding = Color.makeBinding(from: $settings.color)
//                ColorPicker("Color", selection: colorBinding)
//                
//                HStack {
//                    Text("Roughness")
//                    Slider(value: $settings.roughness, in: 0...1)
//                        .transaction { $0.animation = nil }
//                }
//                
//                HStack {
//                    Text("Metallic")
//                    Slider(value: $settings.metallic, in: 0...1)
//                        .transaction { $0.animation = nil }
//                }
//                
//                HStack {
//                    Text("Thickness")
//                    Slider(value: $settings.thickness, in: 0.002...0.02)
//                        .transaction { $0.animation = nil }
//                }
//            }
//        }
//    }
//    
//    private struct SparkleBrushView: View {
//        
//        @Binding var settings: SparkleBrush.Settings
//        
//        var body: some View {
//            VStack {
//                ColorPicker("Color", selection: Color.makeBinding(from: $settings.color))
//                
//                HStack {
//                    Text("Thickness")
//                    Slider(value: $settings.initialSpeed, in: 0.005...0.02)
//                        .transaction { $0.animation = nil }
//                }
//                
//                HStack {
//                    Text("Particle Size")
//                    Slider(value: $settings.size, in: 0.000_15...0.000_35)
//                        .transaction { $0.animation = nil }
//                }
//            }
//        }
//    }
//}
