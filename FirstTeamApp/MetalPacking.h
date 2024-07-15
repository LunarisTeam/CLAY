//
//  MetalPacking.h
//  FirstTeamApp
//
//  Created by Davide Castaldi on 15/07/24.
//

//To use metal utility packages, we can define typedefs to have bridges from metal shading to swift
//we need this so we can work in pure swift
#ifndef MetalPacking_h
#define MetalPacking_h

#include <metal/metal.h>
#include <simd/simd.h>

typedef MTLPackedFloat3 packed_float3;
typedef simd_float2 packed_float2;
typedef struct { _Float16 x, y, z; } packed_float3;

#endif /* MetalPacking_h */
