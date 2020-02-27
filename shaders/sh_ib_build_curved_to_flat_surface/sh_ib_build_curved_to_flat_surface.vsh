attribute vec4 in_Position;
attribute vec2 in_TextureCoord;

varying vec2 data;

uniform vec2 wave_factor;
uniform float precalculated; // cos(blend_factor * PI).

vec4 final_position;
float t;

void main() {
    final_position.x = in_Position.x * precalculated;
    final_position.yw = in_Position.yw;
    final_position.z = sqrt(0.25 - pow(in_Position.x - 0.5, 2.0)) * (1.0 - in_Position.x) * wave_factor.x + pow(in_Position.x, 5.0) * wave_factor.y;
    
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * final_position;
    
    data = vec2(final_position.x * 0.5 + 0.5, final_position.y);
}

