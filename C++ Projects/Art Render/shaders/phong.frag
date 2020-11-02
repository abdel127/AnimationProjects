#version 330

// CSci-4611 Assignment 5:  Art Render

// TODO: You need to calculate per-fragment shading here using the Phong shading
// model.


in vec3 Position;
in vec3 Normal;

out vec4 color;

uniform vec3 lightPosition;
uniform vec4 Ia, Id, Is;

uniform vec4 ka, kd, ks;
uniform float s;


void main() {
	float d1 = Normal[0]*lightPosition[0] + Normal[1]*lightPosition[1] + Normal[2]*lightPosition[2];
	vec3 R = 2 * d1 * Normal - lightPosition;
	float d2 = R[0]*Normal[0] + R[1]*Normal[1] + R[2]*Normal[2];

	float ill0 = ka[0] * Ia[0] + kd[0] * Id[0] * d1 + ks[0] * Is[0] * pow(d2, s);
	float ill1 = ka[1] * Ia[1] + kd[1] * Id[1] * d1 + ks[1] * Is[1] * pow(d2, s);
	float ill2 = ka[2] * Ia[2] + kd[2] * Id[2] * d1 + ks[2] * Is[2] * pow(d2, s);
    color = vec4(ill0, 0.25, 0.2, 1);
}
