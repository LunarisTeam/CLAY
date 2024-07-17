//
//  ImmersiveView.swift
//  FirstTeamApp
//
//  Created by Davide Castaldi on 08/07/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct DrawingView: View {
    
    @Environment(\.dismissWindow) var dismissWindow
    
    //these are the variables for the pinch action
    let thumb = AnchorEntity(.hand(.right, location: .thumbTip))
    let tip = AnchorEntity(.hand(.right, location: .indexFingerTip))
    
    var body: some View {
        
        //here go the entity (scenes, objects)
        RealityView { content in
            let session = SpatialTrackingSession()
            
            let configuration = SpatialTrackingSession.Configuration(tracking: [.hand])
            let unapprovedCapabilities = await session.run(configuration)
            if let unapprovedCapabilities, unapprovedCapabilities.anchor.contains(.hand) {
                //user rejected
            } else {
                //user approved
            }
        }
        .onAppear {
            //dismiss the previous window
            dismissWindow(id: "main")
            
        }
    }
    
//    private func defineMeshResource(for entity: Entity, withMesh mesh: LowLevelMesh) throws {
//        
//        let resource = try? MeshResource(from: mesh)
//        let material = SimpleMaterial()
//        
//        entity.components[ModelComponent.self] = ModelComponent(mesh: resource!, materials: [material])
//        
//        mesh.withUnsafeMutableBytes(bufferIndex: 0) { buffer in
//            let vertices: UnsafeMutableBufferPointer<SolidBrushVertex> = buffer.bindMemory(to: SolidBrushVertex.self)
//        }
//        mesh.withUnsafeMutableIndices { buffer in
//            let indices: UnsafeMutableBufferPointer<UInt32> = buffer.bindMemory(to: UInt32.self)
//        }
//    }
}

#Preview {
    DrawingView()
}
