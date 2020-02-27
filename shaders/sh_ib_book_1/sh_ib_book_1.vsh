#define PI 3.14159265359

attribute vec4 in_Position;
attribute vec2 in_TextureCoord;

varying vec2 v_vTexcoord;
varying vec4 v_vColor;
varying vec4 dithering_coordinate;

uniform vec4 color;
uniform vec3 shadow_color;
uniform float shadow_smoothness;
uniform vec2 wave_factor;
uniform vec4 uvs;
uniform vec4 precalculated_0; // x: sin(blend_factor * PI) * (1.0 - stiffness) * 1.4. y: cos(blend_factor * PI). z: sin(blend_factor * PI) * (1.0 - stiffness) * 0.4 * flip_direction. w: sin(blend_factor * PI) * gm_Matrices[MATRIX_WORLD][0][0] * (0.5 + stiffness * 0.5).
uniform float precalculated_1; // -shadow_x + shadow_smoothness * 0.5. 
uniform float precalculated_2; // 1.0 - clamp((blend_factor * 2.0 - 1.0) * 3.0 * flip_direction, 0.0, 0.9).

vec4 final_position;
float t;

void main() {
    t = in_Position.x - (1.0 - pow(abs(in_Position.x), precalculated_2)) * in_Position.x * precalculated_0.x;
    final_position.x = t * precalculated_0.y + sin(t * PI) * precalculated_0.z;
    final_position.z = t * precalculated_0.w;
    final_position.yw = in_Position.yw;
    
    final_position.z += sqrt(0.25 - pow(in_Position.x - 0.5, 2.0)) * (1.0 - in_Position.x) * wave_factor.x + pow(in_Position.x, 5.0) * wave_factor.y;
    
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * final_position;
    dithering_coordinate = vec4((vec2(gl_Position.x, -gl_Position.y) + (1.0 + 1.0 / 256.0) * gl_Position.w) * 5.0, gl_Position.z, gl_Position.w * 2.0);
    
    v_vTexcoord = uvs.xy + in_TextureCoord * uvs.zw;
    v_vColor = vec4(mix(color.xyz, mix(shadow_color, vec3(1.0), clamp((abs(final_position.x) + precalculated_1) / shadow_smoothness, 0.0, 1.0)), in_Position.x), color.w);
}

