//
//  RWTNoise.fsh
//  RWTPixelShader
//
//  Created by Ricardo on 3/23/14.
//  Copyright (c) 2014 RayWenderlich. All rights reserved.
//

// Precision
precision mediump float;
uniform vec2 uResolution;
uniform float uTime;

float randomNoise(vec2 p) {
    return fract(6791.*sin(47.*p.x+p.y*9973.));
}

void main(void) {
//    float t = uTime/2.;
////    if (t>1.) {
////        t -= floor(t);
////    }
//    t = fract(t);
//    
//    gl_FragColor = vec4(vec3(t), 1.);
    vec2 position = gl_FragCoord.xy/uResolution.xy;
    float n = randomNoise(position);
    gl_FragColor = vec4(vec3(n), 1.);
}
