//
//  SparkleBrushVertex.h
//  FirstTeamApp
//
//  Created by Davide Castaldi on 15/07/24.
//

#pragma once

#include "../../Utilities/MetalPacking.h"
#include <simd/simd.h>

#pragma pack(push, 1)
/// This is the attribute for every brush
struct SparkleBrushAttributes {
    packed_float3 position;
    packed_half3 color;
    float curveDistance;
    float size;
};

/// Describes a particle in the simulation
struct SparkleBrushParticle {
    struct SparkleBrushAttributes attributes;
    packed_float3 velocity;
};

/// One quad (4 vertices) is created per particle
struct SparkleBrushVertex {
    struct SparkleBrushAttributes attributes;
    simd_half2 uv;
};

/// This is to simulate the movement of the brush
struct SparkleBrushSimulationParams {
    uint32_t particleCount;
    float deltaTime;
    float dragCoefficient;
};
#pragma pack(pop)

static_assert(sizeof(struct SparkleBrushAttributes) == 26, "ensure packing");
static_assert(sizeof(struct SparkleBrushParticle) == 38, "ensure packing");
static_assert(sizeof(struct SparkleBrushVertex) == 30, "ensure packing");
static_assert(sizeof(struct SparkleBrushSimulationParams) == 12, "ensure packing");
