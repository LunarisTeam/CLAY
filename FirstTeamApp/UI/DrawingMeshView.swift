//
//  DrawingMeshView.swift
//  FirstTeamApp
//
//  Created by Davide Castaldi on 23/07/24.
//

import Collections
import Foundation
import RealityKit
import RealityKitContent
import SwiftUI

struct DrawingMeshView: View {
    let canvas: DrawingCanvasSettings
    
    @Binding var brushState: BrushState
    
    @State private var drawingDocument: DrawingDocument?
    
    @State private var anchorEntityInput: AnchorEntityInputProvider?
    
    private let syntheticDrawingEntity = ModelEntity(
        mesh: .generateSphere(radius: 0.1),
        materials: [SimpleMaterial(color: .white, isMetallic: true)]
    )
    
    private let rootEntity = Entity()
    private let inputEntity = Entity()
    
    var body: some View {
        RealityView { content in
            SolidBrushSystem.registerSystem()
            SparkleBrushSystem.registerSystem()
            SolidBrushComponent.registerComponent()
            SparkleBrushComponent.registerComponent()
            
            rootEntity.position = .zero
            content.add(rootEntity)
            
            drawingDocument = await DrawingDocument(rootEntity: rootEntity, brushState: brushState, canvas: canvas)
            
            content.add(inputEntity)
                                
            syntheticDrawingEntity.components.set(InputTargetComponent())
            syntheticDrawingEntity.components.set(CollisionComponent(shapes: [.generateSphere(radius: 0.1)]))
            
            content.add(syntheticDrawingEntity)
            
            anchorEntityInput = await AnchorEntityInputProvider(rootEntity: inputEntity, document: drawingDocument!)
        }
        .gesture(
            DragGesture()
                .targetedToEntity(syntheticDrawingEntity)
                .onChanged { value in
                    
                    drawingDocument?.receiveSynthetic(
                        position: syntheticDrawingEntity.position,
                        speed: 1.0,
                        chirality: .right
                    )
                    
                    value.entity.position = value.convert(
                        value.location3D,
                        from: .local,
                        to: value.entity.parent!
                    )
            }
        )
    }
}
