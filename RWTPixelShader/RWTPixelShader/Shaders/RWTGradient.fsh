//
//  RWTGradient.fsh
//  RWTPixelShader
//
//  Created by Ricardo on 3/23/14.
//  Copyright (c) 2014 RayWenderlich. All rights reserved.
//

// Precision
precision highp float;
uniform vec2 uResolution;
uniform float uTime;

void main(void) {
//    vec2 position = gl_FragCoord.xy/uResolution;
//    float gradient =  (position.x + position.y)/2.;
//    gl_FragColor = vec4(0.,gradient, 0., 1.);
    vec2 p = (2.*gl_FragCoord.xy - uResolution.xy)/uResolution.y;
    float tau = 3.1415926535*2.;
    float a = atan(p.x,p.y);
    float r = length(p)*0.75;
    vec2 uv = vec2(a/tau,r);
    
    //get the color
    float xCol = (uv.x - (uTime / 3.)) * 3.;
    xCol = mod(xCol, 3.);
    vec3 horColour = vec3(0.25, 0.25, 0.25);
    
    if (xCol < 1.) {
        
        horColour.r += 1. - xCol;
        horColour.g += xCol;
    }
    else if (xCol < 2.) {
        
        xCol -= 1.;
        horColour.g += 1. - xCol;
        horColour.b += xCol;
    }
    else {
        
        xCol -= 2.;
        horColour.b += 1. - xCol;
        horColour.r += xCol;
    }
    
    // draw color beam
    uv = (2. * uv) - 1.;
    float beamWidth = (0.7+0.5*cos(uv.x*10.0*tau*0.15*clamp(floor(5. + 10.*cos(uTime)), 0., 10.))) * abs(1. / (30. * uv.y));
    vec3 horBeam = vec3(beamWidth);
    gl_FragColor = vec4((( horBeam) * horColour), 1.);
}
