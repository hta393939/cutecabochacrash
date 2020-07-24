// @file atom.frag

#ifdef OPENGL_ES
#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif
#else
precision mediump float;
#endif


uniform vec4 u_diffuseColor;

varying vec2 v_texCoord;

void main() {
	float rr = length(v_texCoord - 0.5) * 2.0;
	float lv = (1.0 - rr) * 1.0;
	gl_FragColor.rgb = u_diffuseColor.rgb * lv;
	gl_FragColor.a = 1.0;
}


