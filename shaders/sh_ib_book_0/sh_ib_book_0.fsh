varying vec2 v_vTexcoord;
varying vec4 v_vColor;

void main() {
    gl_FragColor = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColor;
    gl_FragColor.rgb *= gl_FragColor.a;
}

