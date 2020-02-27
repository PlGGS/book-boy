/// @description  ib_sheet_set_texture(sheet instance id, front texture, back texture, [width], [height], [front uvs], [back uvs], [origin x])
/// @param sheet instance id
/// @param  front texture
/// @param  back texture
/// @param  [width]
/// @param  [height]
/// @param  [front uvs]
/// @param  [back uvs]
/// @param  [origin x]
//
// Changes the texture you initially set with book_add_sheet.
//
// sheet instance id: The instance id of the sheet to set. Returned by book_add_sheet.
// front texture: The id of the texture to cover the front of the sheet. Use the built-in sprite_get_texture, surface_get_texture etc. -1 for no texture.
// back texture: The id of the texture to cover the back of the sheet. Use the built-in sprite_get_texture, surface_get_texture etc. -1 for no texture.
// [width], [height]: The width and height of the sheet. By default this is the actual texture size, but you might want it to be smaller to avoid scaling artifacts when the sheet is transformed.
//     If you omit this parameter or set it to undefined, the width and height of the actual texture is used.
// [front uvs]: The uvs to use for the front texture. If your texture was retrieved with sprite/background_get_texture, this argument should be set to sprite/background_get_uvs. Otherwise you 
//     can omit or set this to undefined.
// [back uvs]: The uvs to use for the back texture. If your texture was retrieved with sprite/background_get_texture, this argument should be set to sprite/background_get_uvs. Otherwise you can
//     omit or set this to undefined.
// [x origin]: The x coordinate in the texture to flip the sheet around. If 0, the sheet will flip around the left edge of the sheet. If e.g. 10, the sheet will flip around the line where x = 10
//     (slightly to the right of the left edge). It's not recommended to set this for sheets other than the first and last sheet of the book. If you omit this parameter or set it to undefined,
//     a default value of 0 is used.

var uvs_0, uvs_1, uvs_2, uvs_3, uvs_4, origin_x, instance, width, height, instance = argument[0];

with (instance.book) {
    if (argument_count > 7 && !is_undefined(argument[7])) origin_x = argument[7]; else origin_x = 0;
    if (argument_count > 3 && !is_undefined(argument[3])) width = argument[3]; else width = round(1 / texture_get_texel_width(argument[1]));
    if (argument_count > 4 && !is_undefined(argument[4])) height = argument[4]; else height = round(1 / texture_get_texel_height(argument[1]));
    
    if (argument_count > 5 && !is_undefined(argument[5])) {
        uvs_0 = argument[5];
        uvs_1[0] = uvs_0[0] + origin_x * texture_get_texel_width(argument[1]); uvs_1[1] = uvs_0[1]; uvs_1[2] = uvs_0[2] - uvs_1[0]; uvs_1[3] = uvs_0[3] - uvs_0[1];
        uvs_3[0] = uvs_0[0]; uvs_3[1] = uvs_0[1]; uvs_3[2] = origin_x * texture_get_texel_width(argument[1]); uvs_3[3] = uvs_0[3] - uvs_0[1];
    } else {
        uvs_1[0] = origin_x * texture_get_texel_width(argument[1]); uvs_1[1] = 0; uvs_1[2] = 1 - uvs_1[0]; uvs_1[3] = 1;
        uvs_3[0] = 0; uvs_3[1] = 0; uvs_3[2] = origin_x * texture_get_texel_width(argument[1]); uvs_3[3] = 1;
    }
    
    if (argument_count > 6 && !is_undefined(argument[6])) {
        uvs_0 = argument[6];
        uvs_2[0] = uvs_0[0] + origin_x * texture_get_texel_width(argument[2]); uvs_2[1] = uvs_0[1]; uvs_2[2] = uvs_0[2] - uvs_2[0]; uvs_2[3] = uvs_0[3] - uvs_0[1];
        uvs_4[0] = uvs_0[0]; uvs_4[1] = uvs_0[1]; uvs_4[2] = origin_x * texture_get_texel_width(argument[2]); uvs_4[3] = uvs_0[3] - uvs_0[1];
    } else {
        uvs_2[0] = origin_x * texture_get_texel_width(argument[2]); uvs_2[1] = 0; uvs_2[2] = 1 - uvs_2[0]; uvs_2[3] = 1;
        uvs_4[0] = 0; uvs_4[1] = 0; uvs_4[2] = origin_x * texture_get_texel_width(argument[2]); uvs_4[3] = 1;
    }
    
    max_sheet_width = max(max_sheet_width, width);
    
    instance.width = width; instance.height = height;
    instance.origin_x = origin_x;
    instance.texture_front = argument[1];
    instance.texture_back = argument[2];
    instance.uvs_front = uvs_1;
    instance.uvs_back = uvs_2;
    instance.uvs_front_edge = uvs_3;
    instance.uvs_back_edge = uvs_4;
    instance.matrix = matrix_build(0, -round(height * 0.5), 0, 0, 0, 0, width - origin_x, height, 1);
    
    if (origin_x != 0) {
        instance.matrix_front_edge = matrix_build(-origin_x, -round(height * 0.5), 0, 0, 0, 0, origin_x, height, 1);
        instance.matrix_back_edge = matrix_build(0, -round(height * 0.5), 0, 0, 0, 0, origin_x, height, 1);
    } else {
        instance.matrix_front_edge = -1;
        instance.matrix_back_edge = -1;
    }
}
