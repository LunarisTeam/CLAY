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
        
    @State private var anchorEntityInput: AnchorEntityInputProvider?
    
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
            
            let drawingDocument = await DrawingDocument(rootEntity: rootEntity, brushState: brushState, canvas: canvas)
            
            content.add(inputEntity)
            
            anchorEntityInput = await AnchorEntityInputProvider(rootEntity: inputEntity, document: drawingDocument)
        }
    }
}
