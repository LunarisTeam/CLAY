//
//  PreviewBrushView.swift
//  FirstTeamApp
//
//  Created by Giuseppe Rocco on 25/07/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct PreviewBrushView: View {

    @Binding var brushState: BrushState
    
    var body: some View {
        RealityView { content in
            SolidBrushSystem.registerSystem()
            
            let entity = Entity()
            
            entity.name = "Brush Preset"
            entity.position.z += 0.005
            content.add(entity)
            
            let simulatedBounds: Float = 0.1
            let selectionShape = ShapeResource.generateSphere(radius: 10)
            
            let shaderInputs = HoverEffectComponent.ShaderHoverEffectInputs.default
            let hoverEffect = HoverEffectComponent.HoverEffect.shader(shaderInputs)
            let hoverEffectComponent = HoverEffectComponent(hoverEffect)
            
            let inputTargetComponent = InputTargetComponent()
            let collisionComponent = CollisionComponent(shapes: [selectionShape], isStatic: true)

            entity.components.set([hoverEffectComponent, inputTargetComponent, collisionComponent])
            
            let presetBrushState = brushState
            
            let solidMaterial = try? await ShaderGraphMaterial(
                named: "/Root/SolidPresetBrushMaterial",
                from: "PresetBrushMaterial",
                in: realityKitContentBundle
            )
            
            var sparkleMaterial = try? await ShaderGraphMaterial(named: "/Root/SparklePresetBrushMaterial",
                from: "PresetBrushMaterial",
                in: realityKitContentBundle
            )
            
            sparkleMaterial?.writesDepth = false
            try? sparkleMaterial?.setParameter(name: "ParticleUVScale", value: .float(8))
            
            var source = await DrawingSource(rootEntity: entity, solidMaterial: solidMaterial, sparkleMaterial: sparkleMaterial)
            
            let samples = PreviewBrushStroke.samples
            for (index, sample) in samples.enumerated() {
                let brushTip = sample * simulatedBounds
                
                let sampleFraction = powf(Float(index) / Float(samples.count), 1.3)
                let speed = mix(0.5, 1.5, t: sampleFraction)
                
                source.receiveSynthetic(
                    position: brushTip,
                    speed: speed,
                    state: presetBrushState
                )
            }
        }
        .frame(depth: 0)
    }
}
