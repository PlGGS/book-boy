/// @description  ib_book_add_sheet(book instance id, front texture, back texture, [width], [height], [front uvs], [back uvs], [sheet index], [thickness], [thickness precision], [stiffness], [transparent], [visibility type], [x origin])
/// @param book instance id
/// @param  front texture
/// @param  back texture
/// @param  [width]
/// @param  [height]
/// @param  [front uvs]
/// @param  [back uvs]
/// @param  [sheet index]
/// @param  [thickness]
/// @param  [thickness precision]
/// @param  [stiffness]
/// @param  [transparent]
/// @param  [visibility type]
/// @param  [x origin]
//
// Adds a sheet to a book and returns its instance id.
//
// book instance id: The instance id of the book. Returned at book creation.
// front texture: The id of the texture to cover the front of the sheet. Use the built-in sprite_get_texture, surface_get_texture etc. -1 for no texture.
// back texture: The id of the texture to cover the back of the sheet. Use the built-in sprite_get_texture, surface_get_texture etc. -1 for no texture.
// [width], [height]: The width and height of the sheet. By default this is the actual texture size, but you might want it to be smaller to avoid scaling artifacts when the sheet is transformed.
//     If you omit this parameter or set it to undefined, the width and height of the actual texture is used.
// [front uvs]: The uvs to use for the front texture. If your texture was retrieved with sprite/background_get_texture, this argument should be set to sprite/background_get_uvs. Otherwise you
//     can omit or set this to undefined.
// [back uvs]: The uvs to use for the back texture. If your texture was retrieved with sprite/background_get_texture, this argument should be set to sprite/background_get_uvs. Otherwise you can
//     omit or set this to undefined.
// [sheet index]: The index to insert the sheet at where 0 is the beginning. If you omit this parameter or set it to undefined, it will be added to the end of the book.
// [thickness]: How thick the sheet is. 0 is no thickness, and is recommended. If higher, the sheet will be drawn multiple times to make the sheet appear thicker. 1 is one more time, 2 is two
//     more times etc. This is just visual, will only come into effect when the sheet is moving, and won't affect the way the sheet bends. If you omit this parameter or set it to undefined,
//     thickness 0 is chosen.
// [thickness precision]: How far apart in degrees the sheets explained in the thickness description will be. If you omit this parameter or set it to undefined, a value of 0.25 degrees is chosen.
// [stiffness]: How unbendable the sheet is. From 0 to 1. For example 1 for hardcover sheets and 0.5 for sheets in between. If you omit this parameter or set it to undefined, stiffness 0.5 is chosen.
// [transparent]: If true, the sheet behind will always be drawn, as if the sheet is transparent.
// [visibility type]: Either 0, 1, 2. If 0, this sheet will be drawn as rarely as possible to avoid speed issues. If 1, the sheet will always be drawn. If 2, the sheet will always be drawn, except
//     possibly when the book is closed (you might want to use this option for the first and last page of the book if they are slightly bigger than the center pages).
// [x origin]: The x coordinate in the texture to flip the sheet around. If 0, the sheet will flip around the left edge of the sheet. If e.g. 10, the sheet will flip around the line where x = 10
//     (slightly to the right of the left edge). It's not recommended to set this for sheets other than the first and last sheet of the book. If you omit this parameter or set it to undefined,
//     a default value of 0 is used.

var instance, uvs_0, uvs_1, uvs_2, uvs_3, uvs_4, index, thickness, thickness_precision, stiffness, transparent, visibility_type, i, j, key_last, change, memory, width, height, t;

with (argument[0]) {
    if (argument_count > 13 && !is_undefined(argument[13])) origin_x = argument[13]; else origin_x = 0;
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
        uvs_2[0] = uvs_0[0]; uvs_2[1] = uvs_0[1]; uvs_2[2] = uvs_0[2] - uvs_0[0] - origin_x * texture_get_texel_width(argument[2]); uvs_2[3] = uvs_0[3] - uvs_0[1];
        uvs_4[0] = uvs_0[2] - origin_x * texture_get_texel_width(argument[2]); uvs_4[1] = uvs_0[1]; uvs_4[2] = origin_x * texture_get_texel_width(argument[2]); uvs_4[3] = uvs_0[3] - uvs_0[1];
    } else {
        uvs_2[0] = 0; uvs_2[1] = 0; uvs_2[2] = 1 - origin_x * texture_get_texel_width(argument[2]); uvs_2[3] = 1;
        uvs_4[0] = 1 - origin_x * texture_get_texel_width(argument[2]); uvs_4[1] = 0; uvs_4[2] = origin_x * texture_get_texel_width(argument[2]); uvs_4[3] = 1;
    }
    
    if (argument_count > 7 && !is_undefined(argument[7])) index = argument[7]; else index = ds_list_size(list_sheets);
    if (argument_count > 8 && !is_undefined(argument[8])) thickness = argument[8]; else thickness = 0;
    if (argument_count > 9 && !is_undefined(argument[9])) thickness_precision = argument[9] / 180 * 2; else thickness_precision = 0.25 / 180 * 2;
    if (argument_count > 10 && !is_undefined(argument[10])) stiffness = argument[10]; else stiffness = 0.5;
    if (argument_count > 11 && !is_undefined(argument[11])) transparent = argument[11]; else transparent = 0;
    if (argument_count > 12 && !is_undefined(argument[12])) visibility_type = argument[12]; else visibility_type = 0;

    max_sheet_width = max(max_sheet_width, width);
    
    instance = instance_create(0, 0, obj_ib_sheet);

    ds_list_insert(list_sheets, index, instance);
    
    instance.width = width; instance.height = height;
    instance.book = id;
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
    
    instance.thickness = thickness;
    instance.thickness_precision = thickness_precision;
    instance.stiffness_default = stiffness;
    instance.stiffness = stiffness;
    instance.timer = lerp(-1, 1, index >= sheet);
    instance.timer_previous = instance.timer;
    instance.flip_direction = 0;
    instance.transparent = transparent;
    instance.visibility_type = visibility_type;
    instance.wave_factor = instance.stiffness_default;
    
    added_to_priority_depth_sort[index] = false;
    
    for (i = ds_list_size(list_sheets_with_special_visibility_type) - 1; i >= 0; --i) {
        if (index <= list_sheets_with_special_visibility_type[| i]) ++list_sheets_with_special_visibility_type[| i];
    }
    if (visibility_type > 0) ds_list_add(list_sheets_with_special_visibility_type, index);
    
    i = ds_map_find_first(map_sheet_alpha); key_last = ds_map_find_last(map_sheet_alpha); j = 0;
    if (ds_map_size(map_sheet_alpha)) while (true) {
        if (index <= i) {change[j] = i; memory[j++] = map_sheet_alpha[? i];}
        if (i == key_last) break;
        i = ds_map_find_next(map_sheet_alpha, i);
    }
    for (i = 0; i < j; ++i) ds_map_delete(map_sheet_alpha, change[i]);
    for (i = 0; i < j; ++i) map_sheet_alpha[? change[i] + 1] = memory[i];
    
    set_to_opaque = 5;
}

return instance;
