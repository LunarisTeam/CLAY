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
    
    //these are the variables for the pinch action
    let thumb = AnchorEntity(.hand(.right, location: .thumbTip))
    let tip = AnchorEntity(.hand(.right, location: .indexFingerTip))
    
    @Environment(\.dismissWindow) var dismissWindow
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
    
    //generates the circle in the ground that can change radius
    private func createGroundEnvironmentMesh() -> MeshResource {
        let outerRadius = 10.0
        let innerRadius = 8.0
        let extrusionDepth: Float = 8.0
        let extrusionOptions = 0
        let path = SwiftUI.Path { path in
            
            path.addArc(center: .zero, radius: outerRadius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
            
            path.addArc(center: .zero, radius: innerRadius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
        }.normalized(eoFill: true)
        
        //these are the option for the count of something, yet to investigate
        var options = MeshResource.ShapeExtrusionOptions()
        options.boundaryResolution = .uniformSegmentsPerSpan(segmentCount: 64)
        options.extrusionMethod = .linear(depth: extrusionDepth)
        
        //MeshResource extruding is an API that converts a 2D vector in 3D model
        do {
            let meshResource = try MeshResource(extruding: path, extrusionOptions: options)
            return meshResource
        } catch {
            print(error)
            return MeshResource.generateSphere(radius: 5.0)
        }
    }
}

#Preview {
    DrawingView()
}
