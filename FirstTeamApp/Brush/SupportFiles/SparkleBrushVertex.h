//
//  SparkleBrushVertex.h
//  FirstTeamApp
//
//  Created by Davide Castaldi on 15/07/24.
//

#ifndef SparkleBrushVertex_h
#define SparkleBrushVertex_h

#include "MetalPacking.h"
#include "Brush/SupportFiles/MetalBridgeHeader.h"

/// This is the attribute for every brush
struct SparkleBrushAttribute {
    packed_float3 position;
    packed_float3 normal;
    float curvedDistance;
    float size;
};

/// Describes a particle in the simulation
struct SparkleBrushParticle {
    struct SparkleBrushAttribute attributes;
    packed_float3 velocity;
};

/// One quad (4 vertices) is created per particle
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

#endif /* SparkleBrushVertex_h */
