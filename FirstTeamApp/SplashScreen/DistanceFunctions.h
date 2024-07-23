//
//  DistanceFunctions.h
//  FirstTeamApp
//
//  Created by Davide Castaldi on 23/07/24.
//

#pragma once

#include <metal_stdlib>
 
// Returns the distance from a point p to line segment a <-> b.
// https://iquilezles.org/articles/distfunctions2d/
inline float distance_to_line_segment(float2 p, float2 a, float2 b)
{
    using namespace metal;
    
    float2 pa = p - a, ba = b - a;
    float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
    return length(pa - ba * h);
}

// Returns the distance from a point p to a box with rounded corners.
// https://iquilezles.org/articles/distfunctions2d/
//
// b.x = width
// b.y = height
// r.x = roundness top-right
// r.y = roundness bottom-right
// r.z = roundness top-left
// r.w = roundness bottom-left
inline float signed_distance_to_rounded_box(float2 p, float2 b, float4 r)
{
    using namespace metal;
    
    r.xy = (p.x > 0.0) ? r.xy : r.zw;
    r.x  = (p.y > 0.0) ? r.x : r.y;
    float2 q = abs(p) - b + r.x;
    return min(max(q.x, q.y), 0.0) + length(max(q, 0.0)) - r.x;
}
