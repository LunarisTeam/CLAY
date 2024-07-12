//
//  DrawingViewExtension.swift
//  FirstTeamApp
//
//  Created by Davide Castaldi on 11/07/24.
//

import Foundation
import SwiftUI
import RealityKit
import RealityKitContent

/// The parameters used for the brush
struct SolidBrushVertex {
    var position: SIMD3<Float>
    var normal: SIMD3<Float>
    var bitangent: SIMD3<Float>
    var color: SIMD3<UInt16>
    var curvedDistance: Float
    var materialProperties: SIMD2<Float>
}

///This is used to create the LowLevelMesh Descriptor used for the brush
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

struct SparkleBrushAttribute {
    var position: SIMD3<Float>
    var normal: SIMD3<Float>
    var curvedDistance: Float
    var size: Float
}

struct SparkleBrushParticle {
    var attributes: SparkleBrushAttribute
    var velocity: SIMD3<Float>
}

struct SparkleBrushVertex {
    var attributes: SparkleBrushAttribute
    var uv: SIMD2<Float>
}

extension SparkleBrushVertex {
    static var vertexAttributes: [LowLevelMesh.Attribute] {
        typealias Attribute = LowLevelMesh.Attribute
        return [
            Attribute(semantic: .position, format: .float3, layoutIndex: 0, offset: MemoryLayout.offset(of: \Self.attributes.position)!),
            Attribute(semantic: .color, format: .half3, layoutIndex: 0, offset: MemoryLayout.offset(of: \Self.attributes.normal)!),
            Attribute(semantic: .uv0, format: .half2, layoutIndex: 0, offset: MemoryLayout.offset(of: \Self.uv)!),
            Attribute(semantic: .uv1, format: .float, layoutIndex: 0, offset: MemoryLayout.offset(of: \Self.attributes.curvedDistance)!),
            Attribute(semantic: .uv2, format: .float, layoutIndex: 0, offset: MemoryLayout.offset(of: \Self.attributes.size)!),
            
        ]
    }
}

extension DrawingView {
    
    /// Generates the circle in the ground that can change radius
    /// - Returns: returns the groundEnvironment
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
        
        //MeshResource extruding converts a 2D vector in 3D model
        do {
            let meshResource = try MeshResource(extruding: path, extrusionOptions: options)
            return meshResource
        } catch {
            print(error)
            return MeshResource.generateSphere(radius: 5.0)
        }
    }
    
    /// Creates the entity hovering
    /// - Returns: the hovering on entity
    private func createEnvironmentEntity() async throws -> Entity {
        
        let placementEntity: Entity = try await Entity(named: "Scene")
        let hover = HoverEffectComponent(.highlight(
            .init(
                color: .blue,
                strength: 5.0)
            )
        )
        
        placementEntity.components.set(hover)
        return placementEntity
    }
    
    /// Adds a glowing effect to applied entity
    private func createAdditiveBlendModel() async {
        
        //create an unlit material and add the blendin to background color
        var descriptor = UnlitMaterial.Program.Descriptor()
        descriptor.blendMode = .add
        
        let prog = await UnlitMaterial.Program(descriptor: descriptor)
        var material = UnlitMaterial(program: prog)
        
        material.color = UnlitMaterial.BaseColor(tint: .green)
    }
    
    /// Creates a trail effect
    /// - Parameter entity: shaded entity
    private func createShaderHoverFX(for entity: Entity) async throws {
        let hoverEffectComponent = HoverEffectComponent(.shader(.default))
        entity.components.set(hoverEffectComponent)
        
        let material = try await ShaderGraphMaterial(named: "/Root/SolidPresetBrushMaterial", from: "PresetBrushMaterial", in: realityKitContentBundle)
        
        let sphere = MeshResource.generateSphere(radius: 5)
        
        entity.components.set(ModelComponent.init(mesh: sphere, materials: [material]))
    }
    
    /// Creates the LowLevelMesh descriptor with the parameters used
    /// - Parameters:
    ///   - vertexBufferSize: the vertex buffer size contains all the important parameters
    ///   - indexBufferSize: the index buffer size contains is the index
    ///   - meshBounds: the meshes
    /// - Returns: A mesh following the LowLevelMeshr we define
    private static func createLowLevelMeshDescriptor(vertexBufferSize: Int, indexBufferSize: Int, meshBounds: BoundingBox) throws -> LowLevelMesh {
        
        //the LowLevelMesh needs a descriptor, but we need to create a descriptor suiting our needs
        
        var descriptor = LowLevelMesh.Descriptor() //it's very similar to MTLVertexDescriptor
        let stride = MemoryLayout<SolidBrushVertex>.stride
        
        descriptor.vertexCapacity = vertexBufferSize
        descriptor.indexCapacity = indexBufferSize
        descriptor.vertexAttributes = SolidBrushVertex.vertexAttributes
        descriptor.vertexLayouts = [LowLevelMesh.Layout(bufferIndex: 0, bufferOffset: 0, bufferStride: stride)]
        
        let mesh = try LowLevelMesh(descriptor: descriptor)
        
        mesh.parts.append(LowLevelMesh.Part.init(indexOffset: 0, indexCount: indexBufferSize, topology: .triangleStrip, materialIndex: 0, bounds: meshBounds))
        
        return mesh
    }
    
    /// Populates the mesh through MTLComputeCommandEncoder. RealityKit automatically updates these changes
//    private func lowLevelMeshCompute() {
//        
//        let inputParticleBuffer: MTLBuffer
//        let lowLevelMesh: LowLevelMesh
//        
//        let commandBuffer: MTLCommandBuffer
//        let encoder: MTLComputeCommandEncoder
//        let populatePipeline: MTLComputePipelineState
//        
//        commandBuffer.enqueue()
//        encoder.setComputePipelineState(populatePipeline)
//        
//        let vertexBuffer: MTLBuffer = lowLevelMesh.replace(bufferIndex: 0, using: commandBuffer)
//        
//        encoder.setBuffer(inputParticleBuffer, offset: 0, index: 0)
//        encoder.setBuffer(vertexBuffer, offset: 0, index: 1)
//        encoder.dispatchThreadgroups(<#T##threadgroupsPerGrid: MTLSize##MTLSize#>, threadsPerThreadgroup: <#T##MTLSize#>)
//        
//        encoder.endEncoding()
//        commandBuffer.commit()
//    }
    
}
