//
//  SolidBrush.swift
//  FirstTeamApp
//
//  Created by Giuseppe Rocco on 15/07/24.
//

//struct SolidBrush {
//    
//    struct CurvePoint {
//        var position: SIMD3<Float>
//        var radius: Float
//        var color: SIMD3<Float>
//        var roughness: Float
//        var metallic: Float
//        var positionAndRadius: SIMD4<Float> { .init(position, radius) }
//        
//        init(position: SIMD3<Float>, radius: Float, color: SIMD3<Float>, roughness: Float, metallic: Float) {
//            self.position = position
//            self.radius = radius
//            self.color = color
//            self.roughness = roughness
//            self.metallic = metallic
//        }
//        
//        init(positionAndRadius par: SIMD4<Float>, color: SIMD3<Float>, roughness: Float, metallic: Float) {
//            self.position = SIMD3(par.x, par.y, par.z)
//            self.radius = par.w
//            self.color = color
//            self.roughness = roughness
//            self.metallic = metallic
//        }
//    }
//    
//    struct Settings: Equatable, Hashable {
//        var thickness: Float = 0.005
//        var color: SIMD3<Float> = [1, 1, 1]
//        var metallic: Float = 0
//        var roughness: Float = 0.5
//    }
//    
//    func styleInput(position: SIMD3<Float>, speed: Float, settings: Settings) -> SolidBrush.CurvePoint {
//        SolidBrush.CurvePoint(position: position,
//                             radius: settings.thickness,
//                             color: settings.color,
//                             roughness: settings.roughness,
//                             metallic: settings.metallic)
//    }
//}
