//
//  SparkleBrushVertex+LowLevelMesh.swift
//  FirstTeamApp
//
//  Created by Davide Castaldi on 15/07/24.
//

import RealityFoundation
import SwiftUI

/// This is used to create the LowLevelMesh Descriptor used for the brush
/// A mesh is a collection of vetices. A vertex is composed by these parameters. Every vertex follows the next one to create the shader effect
extension SparkleBrushVertex {
    static var vertexAttributes: [LowLevelMesh.Attribute] {
        typealias Attribute = LowLevelMesh.Attribute
        
        return [
            Attribute(semantic: .position, format: .float3, layoutIndex: 0,
                      offset: MemoryLayout.offset(of: \Self.attributes.position)!),
            
            Attribute(semantic: .color, format: .half3, layoutIndex: 0,
                      offset: MemoryLayout.offset(of: \Self.attributes.color)!),
            
            Attribute(semantic: .uv0, format: .half2, layoutIndex: 0,
                      offset: MemoryLayout.offset(of: \Self.uv)!),
            
            Attribute(semantic: .uv1, format: .float, layoutIndex: 0,
                      offset: MemoryLayout.offset(of: \Self.attributes.curveDistance)!),
            
            Attribute(semantic: .uv2, format: .float, layoutIndex: 0,
                      offset: MemoryLayout.offset(of: \Self.attributes.size)!)
        ]
    }
}

