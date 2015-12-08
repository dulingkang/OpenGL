//
//  RWTNoise.fsh
//  RWTPixelShader
//
//  Created by Ricardo on 3/23/14.
//  Copyright (c) 2014 RayWenderlich. All rights reserved.
//

// Precision
precision highp float;
uniform vec2 uResolution;
uniform float uTime;

float randomNoise(vec2 p) {
    return fract(6791.*sin(47.*p.x+p.y*9973.));
}

float smoothNoise(vec2 p) {
    vec2 nn = vec2(p.x, p.y+1.);
    vec2 ne = vec2(p.x+1., p.y+1.);
    vec2 ee = vec2(p.x+1., p.y);
    vec2 se = vec2(p.x+1., p.y-1.);
    vec2 ss = vec2(p.x, p.y-1.);
    vec2 sw = vec2(p.x-1., p.y-1.);
    vec2 ww = vec2(p.x-1., p.y);
    vec2 nw = vec2(p.x-1., p.y+1.);
    vec2 cc = vec2(p.x, p.y);
    
    float sum = 0.;
    sum += randomNoise(nn);
    sum += randomNoise(ne);
    sum += randomNoise(ee);
    sum += randomNoise(se);
    sum += randomNoise(ss);
    sum += randomNoise(sw);
    sum += randomNoise(ww);
    sum += randomNoise(nw);
    sum += randomNoise(cc);
    sum /= 9.;
    
    return sum;
}

float interpolatedNoise(vec2 p) {
    vec2 s = smoothstep(0., 1., fract(p));
    float q11 = smoothNoise(vec2(floor(p.x), floor(p.y)));
    float q12 = smoothNoise(vec2(floor(p.x), ceil(p.y)));
    float q21 = smoothNoise(vec2(ceil(p.x), floor(p.y)));
    float q22 = smoothNoise(vec2(ceil(p.x), ceil(p.y)));
    
    float r1 = mix(q11, q21, s.x);
    float r2 = mix(q12, q22, s.x);
    
    return mix (r1, r2, s.y);
}

void main(void) {
//    float t = uTime/2.;
////    if (t>1.) {
////        t -= floor(t);
////    }
//    t = fract(t);
//    
//    gl_FragColor = vec4(vec3(t), 1.);
//    vec2 position = gl_FragCoord.xy/uResolution.xy;
//    float n = randomNoise(position);
//    gl_FragColor = vec4(vec3(n), 1.);
    
//    vec2 position = gl_FragCoord.xy/uResolution.xx;
//    if ((position.x>1.) || (position.y>1.)) {
//        discard;
//    }
//    float tiles = 2.;
//    position = floor(position*tiles);
//    float n = randomNoise(position);
//    gl_FragColor = vec4(vec3(n), 1.);
    
    vec2 position = gl_FragCoord.xy/uResolution.xx;
    float tiles = 4.;
    position *= tiles;
    float n = interpolatedNoise(position);
    gl_FragColor = vec4(vec3(n), 1.);
}
