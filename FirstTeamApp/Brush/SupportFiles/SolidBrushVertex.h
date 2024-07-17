//
//  SolidBrushVertex.h
//  FirstTeamApp
//
//  Created by Davide Castaldi on 15/07/24.
//

#ifndef SolidBrushVertex_h
#define SolidBrushVertex_h

#include "MetalPacking.h"
#include "Brush/SupportFiles/MetalBridgeHeader.h"

struct SolidBrushVertex {
    packed_float3 position;
    packed_float3 normal;
    packed_float3 bitangent;
    packed_float2 materialProperties; // X = Roughness, Y = Metallic
    float curveDistance;
    packed_half3 color;
};

#endif /* SolidBrushVertex_h */
