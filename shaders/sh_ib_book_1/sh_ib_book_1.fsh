varying vec2 v_vTexcoord;
varying vec4 v_vColor;
varying vec4 dithering_coordinate;

uniform sampler2D texture_dithering_pattern;

void main() {
    gl_FragColor = texture2D(gm_BaseTexture, v_vTexcoord) * vec4(v_vColor.rgb + 0.02 * texture2D(texture_dithering_pattern, dithering_coordinate.xy / dithering_coordinate.w).r, v_vColor.a);
    gl_FragColor.rgb *= gl_FragColor.a;
}

