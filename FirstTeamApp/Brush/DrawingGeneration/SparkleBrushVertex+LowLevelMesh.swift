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
extension SolidBrushVertex {
    static var vertexAttributes: [LowLevelMesh.Attribute] {
        typealias Attribute = LowLevelMesh.Attribute
        return [
            Attribute(semantic: .position, format: MTLVertexFormat.float3, layoutIndex: 0, offset: MemoryLayout.offset(of: \Self.position)!),
            Attribute(semantic: .normal, format: MTLVertexFormat.float3, layoutIndex: 0, offset: MemoryLayout.offset(of: \Self.normal)!),
            Attribute(semantic: .bitangent, format: MTLVertexFormat.float3, layoutIndex: 0, offset: MemoryLayout.offset(of: \Self.bitangent)!),
            Attribute(semantic: .color, format: MTLVertexFormat.half3, layoutIndex: 0, offset: MemoryLayout.offset(of: \Self.color)!),
            Attribute(semantic: .uv1, format: MTLVertexFormat.float, layoutIndex: 0, offset: MemoryLayout.offset(of: \Self.curvedDistance)!),
            Attribute(semantic: .uv3, format: MTLVertexFormat.float2, layoutIndex: 0, offset: MemoryLayout.offset(of: \Self.materialProperties)!),
        ]
    }
}
