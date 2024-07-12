//
//  ContentViewExtension.swift
//  FirstTeamApp
//
//  Created by Davide Castaldi on 12/07/24.
//

import Foundation
import RealityFoundation
import UIKit
import SwiftUI

extension ContentView {
    
    /// creates the menu text and centers it (fun fact i had to this from scratch before VisionOS 2.0)
    private func createMenuText() async {
        
        //creation of the text
        var textString = AttributedString("RealityKit")
        textString.font = .systemFont(ofSize: 8.0)
        
        let secondLineFont = UIFont(name: "ArialRoundedMTBold", size: 14.0)
        
        let attributes = AttributeContainer([.font: secondLineFont])
        
        textString.append(AttributedString("\nDrawing App", attributes: attributes))
        
        var extrusionOptions = MeshResource.ShapeExtrusionOptions()
        extrusionOptions.extrusionMethod = .linear(depth: 2)
        extrusionOptions.materialAssignment = .init(front: 0, back: 0, extrusion: 1, frontChamfer: 1, backChamfer: 1)
        extrusionOptions.chamferRadius = 0.1
        
        let graphic = SwiftUI.Path { path in
            path.move(to: CGPoint(x: -0.7, y: 0.135413))
            path.addCurve(to: CGPoint(x: -0.7, y: 0.042066), control1: CGPoint(x: -0.85, y: 067707), control2: CGPoint(x: -0.85, y: 021033))
            //other things
        }
        
        //let's center it
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let centerAttributes = AttributeContainer([.paragraphStyle: paragraphStyle])
        textString.mergeAttributes(centerAttributes)
        
        //finally add it
        do {
            let textMesh = try await MeshResource(extruding: textString, extrusionOptions: extrusionOptions)
        } catch {
            print(error)
        }
    }
    
    /// creates the moving background starting from the descriptor of LowLevelTexture.
    private func createMovingBackground() -> UnlitMaterial {
        
        let textureResolution = 100
        
        //we are going to use only the red and green channels
        let descriptor = LowLevelTexture.Descriptor(pixelFormat: .rg16Float, width: textureResolution, height: textureResolution, textureUsage: [.shaderWrite, .shaderRead])
        
        
        let lowLevelTexture = try? LowLevelTexture(descriptor: descriptor)
        var textureResource = try? TextureResource(from: lowLevelTexture!)
        
        var material = UnlitMaterial()
        material.color = .init(tint: .white, texture: .init(textureResource!))
        
        return material
    }
    
    /// Populates the mesh through MTLComputeCommandEncoder. RealityKit automatically updates these changes
//    private func lowLevelTextureCompute() {
//        
//        let lowLevelTexture: LowLevelTexture
//        
//        let commandBuffer: MTLCommandBuffer
//        let encoder: MTLComputeCommandEncoder
//        let computePipeline: MTLComputePipelineState
//        
//        commandBuffer.enqueue()
//        encoder.setComputePipelineState(computePipeline)
//
//        let writeTexture: MTLTexture = lowLevelTexture.replace(using: commandBuffer)
//        encoder.setTexture(writeTexture, index: 0)
//       
//        encoder.dispatchThreadgroups(<#T##threadgroupsPerGrid: MTLSize##MTLSize#>, threadsPerThreadgroup: <#T##MTLSize#>)
//        
//        encoder.endEncoding()
//        commandBuffer.commit()
//    }
}
