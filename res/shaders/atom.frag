// @file atom.frag

#ifdef OPENGL_ES
precision highp float;
#endif

uniform vec4 u_diffuseColor;

varying vec2 v_texCoord;

void main() {
	float rr = length(v_texCoord - 0.5) * 2.0;
	float lv = (1.0 - rr) * 1.0;
	gl_FragColor.rgb = u_diffuseColor.rgb * lv;
	gl_FragColor.a = 1.0;
}
