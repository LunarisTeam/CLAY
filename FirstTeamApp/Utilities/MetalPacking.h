//
//  MetalPacking.h
//  FirstTeamApp
//
//  Created by Davide Castaldi on 15/07/24.
//

//To use metal utility packages, we can define typedefs to have bridges from metal shading to swift
//we need this so we can work in pure swift

#pragma once

#ifndef __METAL_VERSION__

#include <metal/metal.h>
#include <simd/simd.h>

typedef MTLPackedFloat3 packed_float3;
typedef simd_float2 packed_float2;
typedef struct { _Float16 x, y, z; } packed_half3;

#endif // __METAL_VERSION__
