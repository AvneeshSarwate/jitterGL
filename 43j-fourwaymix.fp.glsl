uniform vec4 a;
uniform vec4 b;
uniform vec4 c;
uniform vec4 d;
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



void main (void)
{
    vec2 resolution = vec2(320., 240);
	// sample our textures
	vec4 input0 = texture2DRect(tex0, mod(texcoord0 + time*20., resolution));
	vec4 input1 = texture2DRect(tex1, mod(texcoord1 + time*20., resolution));
	vec4 input2 = texture2DRect(tex2, texcoord2);
	vec4 input3 = texture2DRect(tex3, texcoord3);
	
    vec4 c;
    if(texcoord0.y > resolution.y / 2.) c = input0;
    else c = input1;
	// perform our calculation and write our data to the fragment color
	gl_FragColor = c;
    // gl_FragColor = vec4(texcoord0.x/320., texcoord0.y/240., mod(time, 1.0), 0.);
	
}
