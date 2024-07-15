//
//  MetalShader.metal
//  FirstTeamApp
//
//  Created by Davide Castaldi on 11/07/24.
//

#include <metal_stdlib>
#include "SparkleBrushVertex.h"

//A compute kernel written in metal to simulate the particles in a Sparkle brush stroke,
//and also to populate the mesh of a sparkle brush with the result of the simulation.

using namespace metal;

//this kernel function populates vertex data for rendering a sparkle brush
[[kernel]]
void sparkleBrushPopulate(device const SparkleBrushParticle *particles [[buffer(0)]],
                          device SparkleBrushVertex *output [[buffer(1)]],
                          constant const uint32_t &particleCount [[buffer(2)]],
                          uint particleIdx [[thread_position_in_grid]]) {
    
    //guard condition. If the particle is within range then continue
    if (particleIdx >= particleCount) {
        return;
    }
    
    //retrieve the particle data for the current index
    SparkleBrushParticle particle = particles[particleIdx];
    
    //having the singular particle, we need the starting index for the particle's vertices in the output buffer
    const uint startIndex = particleIdx * 4;
    
    //so that we can fill the output buffer. Each particle is represented by 4 vertices forming a quad
    output[startIndex + 0] = SparkleBrushVertex { .attributes = particle.attributes, .uv = {0, 0}};
    output[startIndex + 1] = SparkleBrushVertex { .attributes = particle.attributes, .uv = {0, 1}};
    output[startIndex + 2] = SparkleBrushVertex { .attributes = particle.attributes, .uv = {1, 0}};
    output[startIndex + 3] = SparkleBrushVertex { .attributes = particle.attributes, .uv = {1, 1}};
}

//this kernel function simulates the physics of particles in a sparkle brush
[[kernel]]
void sparkleBrushSimulate(device const SparkleBrushParticle *particles [[buffer(0)]],
                          device SparkleBrushParticle *output [[buffer(1)]],
                          constant SparkleBrushSimulationParams &params [[buffer(2)]],
                          uint particleIdx [[thread_position_in_grid]]
                          ) {
    
    //same guard condition. If the particle is within range then continue
    if (particleIdx >= params.particleCount) {
        return;
    }
    
    //same retrieval the particle data for the current index
    SparkleBrushParticle particle = particles[particleIdx];
    
    /*
     to draw we need to compute 3 different actions:
     1) The speed at which we have to draw the square, this depends on the drag factor from the formula D = 1/2ρV^2
     2) The drag force, based on a coefficient and delta time for responsiveness
     3) The current speed of the particle, that depends on
     
     Here come into play the values we defined in the header files
     */
    
    //1)
    const float speed2 = length_squared(particle.velocity);
    
    //2)
    const float dragForce = -speed2 * (params.dragCoefficient * params.deltaTime);
    
    //define the speed as a linear value
    const float speed = sqrt(speed2);
    
    //3)
    const float newSpeed = max(0.f, speed + dragForce);
    
    if (min(newSpeed, speed) > 0.0001) {
        particle.velocity = particle.velocity / (speed * newSpeed);
    } else {
        particle.velocity = 0;
    }
}
