// @file fire.frag

#ifdef OPENGL_ES
precision highp float;
#endif

uniform sampler2D u_fireTexture;

varying vec2 v_texCoord;
varying vec2 v_fireTex;

void main() {
	float rr = length(v_texCoord - 0.5) * 2.0;
	float lv = (1.0 - rr) * 1.0;
	gl_FragColor.rgb = texture2D(u_fireTexture, v_fireTex).rgb * lv;
	gl_FragColor.a = 1.0;
}
