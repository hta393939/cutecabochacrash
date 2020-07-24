// @file atom.vert

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
uniform float u_side;

varying vec2 v_texCoord;

#include "skinning-none.vert"

#define PI 3.141592
#define PI2 (PI * 2.0)

vec4 rotq(in vec3 p, in vec4 q) {
// p.w = 0.0
	vec4 fw = vec4(q.w * p + cross(q.xyz, p), - dot(q.xyz, p));
	vec4 ret = vec4(- fw.w * q.xyz + q.w * fw.xyz + cross(fw.xyz, -q.xyz), 1.0);
	return ret;
}

void main() {
	v_texCoord = a_texCoord;

	vec4 position = a_position;
	float id = position.z;

	vec4 sk = vec4(u_matrixPalette[0].w,
		u_matrixPalette[1].w,
		u_matrixPalette[2].w,
		1);

	float t = id * 3.1 + u_speed * sk.z;
	float topo = fract(t);

	float ang1 = t * PI2 * 1.5;
	float ang2 = topo * (fract(id * 0.5) * 4.0 - 1.0);
	float ang3 = t * PI2;

	float x = cos(ang1);
	float y = sin(ang1);
	float z = 0.0;

	vec4 v = vec4(cos(ang2), 0.0, sin(ang2), 1.0);
	v.xyz *= sin(ang3 * 0.5);
	v.w = cos(ang3 * 0.5);

	vec4 oPos = rotq(vec3(x,y,z), v);

	oPos.xyz *= u_spread;

	vec4 wPos = u_worldMatrix * oPos;
	vec4 viewPos = u_viewMatrix * wPos;

	viewPos.xy += position.xy * u_side * 0.5;
	gl_Position = u_projectionMatrix * viewPos;

//	gl_Position = a_position;
}
