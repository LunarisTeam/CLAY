//
//  MetalShader.metal
//  FirstTeamApp
//
//  Created by Davide Castaldi on 11/07/24.
//

#include <metal_stdlib>
using namespace metal;

//MARK: This is probably useless at the moment...?
/// A mesh is a collection of vetices. A vertex is composed by these parameters. Every vertex follows the next one to create the shader effect
struct SolidBrushVertex {
    packed_float3 position;
    packed_float3 normal;
    packed_float3 bitangent;
    packed_float2 materialProperties;
    float curvedDistance;
    packed_half3 color;
};

struct SparkleBrushAttribute {
    packed_float3 position;
    packed_float3 normal;
    float curvedDistance;
    float size;
};

/// Describes a particle in the simulation
struct SparkBrushParticle {
    struct SparkleBrushAttribute attributes;
    packed_float3 velocity;
};

/// one quad (4 vertices) is created per particle
struct Spark {
    struct SparkleBrushAttribute attributes;
    simd_half2 uv;
};
