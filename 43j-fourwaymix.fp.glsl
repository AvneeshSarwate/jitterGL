uniform float time;

// define our varying texture coordinates
varying vec2 texcoord0;
varying vec2 texcoord1;
varying vec2 texcoord2;
varying vec2 texcoord3;

// define our rectangular texture samplers
uniform sampler2DRect tex0;
uniform sampler2DRect tex1;
uniform sampler2DRect tex2;
uniform sampler2DRect tex3;

vec2 resolution = vec2(320., 240);
vec2 center = resolution/2.;

vec2 rotate(vec2 space, vec2 center, float amount){
    return vec2(cos(amount) * (space.x - center.x) + sin(amount) * (space.y - center.y) + center.x,
        cos(amount) * (space.y - center.y) - sin(amount) * (space.x - center.x) + center.y);
}

float quant(float num, float quantLevels){
    float roundPart = floor(fract(num*quantLevels)*2.);
    return (floor(num*quantLevels)+roundPart)/quantLevels;
}

// same as above but for vectors, applying the quantization to each element
vec3 quant(vec3 num, float quantLevels){
    vec3 roundPart = floor(fract(num*quantLevels)*2.);
    return (floor(num*quantLevels)+roundPart)/quantLevels;
}

// same as above but for vectors, applying the quantization to each element
vec2 quant(vec2 num, float quantLevels){
    vec2 roundPart = floor(fract(num*quantLevels)*2.);
    return (floor(num*quantLevels)+roundPart)/quantLevels;
}

vec2 uvN(void){return (gl_FragCoord.xy / resolution);}
vec2 uvNS(vec2 stN){return stN * resolution;}

void main (void)
{
    
	// sample our textures
	vec4 input0 = texture2DRect(tex0, texcoord0);
	vec4 input1 = texture2DRect(tex1, texcoord1);
	vec4 input2 = texture2DRect(tex2, texcoord2);
	vec4 input3 = texture2DRect(tex3, texcoord3);

    vec2 stN = uvN();
    stN = rotate(stN, vec2(0.5), time);
    float numStripes = 10.;
    float stripeMod = mod(floor(quant(stN.x, numStripes)*numStripes), 3.);   
    vec4 cc = vec4(0.);
    if(stripeMod == 0.) cc = input0;
    if(stripeMod == 1.) cc = input1;
    if(stripeMod == 2.) cc = input2;

	// perform our calculation and write our data to the fragment color
	gl_FragColor = cc;
    // gl_FragColor = vec4(texcoord0.x/320., texcoord0.y/240., mod(time, 1.0), 0.);
	
}
