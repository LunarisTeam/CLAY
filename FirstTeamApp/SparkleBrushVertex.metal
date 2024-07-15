//
//  MetalShader.metal
//  FirstTeamApp
//
//  Created by Davide Castaldi on 11/07/24.
//

#include <metal_stdlib>
#include "MetalPacking.h"
#include <simd/simd.h>

using namespace metal;

//MARK: This is probably useless at the moment...?

/// This is the attribute for every brush
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
struct SparkleBrushVertex {
    struct SparkleBrushAttribute attributes;
    simd_half2 uv;
};

/// This is to simulate the movement of the brush
struct SparkleBrushSimulationParams {
    uint32_t particleCount;
    float deltaTime;
    float dragCoefficient;
};
