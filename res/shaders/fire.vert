// @file fire.vert

#ifdef OPENGL_ES
#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif
#else
precision mediump float;
#endif


attribute vec4 a_position;
attribute vec3 a_normal;
attribute vec2 a_texCoord;

uniform mat4 u_worldMatrix;
uniform mat4 u_viewMatrix;
uniform mat4 u_projectionMatrix;

uniform vec4 u_matrixPalette[SKINNING_JOINT_COUNT * 3];

uniform float u_spread;
uniform float u_speed;
uniform float u_height;
uniform float u_side;

varying vec2 v_texCoord;
varying vec2 v_fireTex;

#include "skinning-none.vert" 

#define PI 3.141592
#define PI2 (PI * 2.0)

void main() {
	v_texCoord = a_texCoord;

	vec4 position = a_position;
	float id = position.z;

	vec4 sk = vec4(u_matrixPalette[0].w,
		u_matrixPalette[1].w,
		u_matrixPalette[2].w,
		1);

	float t = id * 0.01 + u_speed * sk.z;
	float topo = fract(t);

	float y = u_height * topo;

	float env = min(1.0, pow(topo / 0.2, 0.5));
	float side = u_side * env * min(1.0, (1.0 - topo) / 0.6);

	float rr = u_spread * env;

	vec4 oPos = vec4(rr*cos(topo + id*52.0), y, rr*sin(topo + id*23.0), 1.0);
	vec4 wPos = u_worldMatrix * oPos;
	vec4 viewPos = u_viewMatrix * wPos;

// ÉJÉÅÉâç¿ïWånÇ≈ë´ÇµÇ±Çﬁ
	viewPos.xy += position.xy * side * 0.5;
	gl_Position = u_projectionMatrix * viewPos;

	v_fireTex = vec2(0.5, topo);
}
