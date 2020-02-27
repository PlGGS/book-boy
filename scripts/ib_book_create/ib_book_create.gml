/// @description  ib_book_create(x, y, [precision x], [precision y], [fade in speed], [fade out speed], [shadow color], [light source distance], [shadow smoothness], [gradient color], [inner wave factor], [outer wave factor], [wave dependence], [page flip smoothing], [dithering])
/// @param x
/// @param  y
/// @param  [precision x]
/// @param  [precision y]
/// @param  [fade in speed]
/// @param  [fade out speed]
/// @param  [shadow color]
/// @param  [light source distance]
/// @param  [shadow smoothness]
/// @param  [gradient color]
/// @param  [inner wave factor]
/// @param  [outer wave factor]
/// @param  [wave dependence]
/// @param  [page flip smoothing]
/// @param  [dithering]
//
// Creates a book instance and returns its id.
//
// x, y: The x- and y-coordinate of the book. The book will be centered at this position.
// [precision x], [precision y]: These decide the number of vertices per sheet. A precision x of 10 gives the sheet 10 quads horizontally. Usually you want the ratio width / height to be close to
//     precision x / precision y. If you omit these arguments or set them to undefined, a default precision of 30, 45 is used.
// [fade in speed]: If your book has many sheets, it would slow down your game to draw them all. This asset is optimized so that the book is rendered efficiently. If you flip a sheet, the sheet
//     behind might suddenly appear, in which case you might want it to fade in so that it looks less sudden. This works well if your sheets have uneven edges. If your sheet has e.g. holes in it
//     or is half torn apart, you might want to mark the sheet as transparent instead so that the sheet behind is drawn anyway (which can be done in book_add_sheet). The fade in speed should be from
//     (greater than) 0 to 1. If you omit this parameter or set it to undefined, a default value of 0.1 is used.
// [fade out speed]: If you flip a sheet and cover another sheet with it, the sheet you covered might suddenly disappear, in which case you might want it to fade out so that it looks less sudden.
//     This works well if your sheets have uneven edges. If your sheet has e.g. holes in it or is half torn apart, you might want to mark the sheet as transparent so that the sheet behind is
//     drawn anyway (which can be done in book_add_sheet). The fade out speed should be from (greater than) 0 to 1. If you omit this parameter or set it to undefined, a default value of 0.1
//     is used.
// [shadow color]: The color for the casted shadows. The color is multiplied. A completely white color like c_white will therefore be the same as disabling casted shadows. c_gray will be half
//     transparent casted shadows. If you omit this parameter or set it to undefined, a default value of $AAAAAA (very light gray) is used.
// [light source distance]: The light source for shadow casting is positioned in front of the book at a certain distance from it. This parameter specifies that distance. 1 is the same distance
//     as the sheet width, 2 is twice that distance, etc. If your shadow color is completely white (disabled), you can ignore this parameter. If you omit this parameter or set it to undefined,
//     a default value of 3 is used.
// [shadow smoothness]: How smooth the casted shadows are. A value of 0 is hard shadows (how hard they are depends on [precision x] since the color is calculated in the vertex shader). A value
//     of 1 is really smooth. The value is about the same as the width of the gradient near the shadow edge where 1 is the same as the sheet width. If you omit this parameter or set it to
//     undefined, a default smoothness of 0.1 is used.
// [gradient color]: The color of a gradient overlaying the sheets. The color is multiplied. A completely white color like c_white will therefore be the same as disabling gradients. c_gray will
//     be half transparent gradients. The gradients are not affected by other sheets like casted shadows are. If you omit this parameter or set it to undefined, a default value of $AAAAAA
//     (light gray) is used.
// [inner wave factor]: If you open a book and look at it from the side, sometimes the sheets will curve outwards like some kind of wave, especially if you have a lot of sheets on top of each
//     other. This specifies how much of the inner part of the wave you want, a factor to multiply with the wave height. Set this to 0 for no inner waves. If you omit this parameter or set it to
//     undefined, a default value of 1 is used.
// [outer wave factor]: If you open a book and look at it from the side, sometimes the sheets will curve outwards like some kind of wave, especially if you have a lot of sheets on top of each
//     other. This specifies how much of the outer part of the wave you want, a factor to multiply with the wave height. Set this to 0 for no outer waves. If you omit this parameter or set it to
//     undefined, a default value of 0 is used.
// [wave dependence]: You might want the size of the wave to depend on how many sheets are on top of each other. Set this to 0 if you always want it to stay the same. Set this to 1 if you want the
//     wave to completely disappear near the ends of the book. The value should be between 0 and 1, and the higher the value is the less apparent the wave will be near the ends of the book. If you
//     omit this parameter or set it to undefined, a default value of 0 is used.
// [page flip smoothing]: Set this to true if you want the page flipping to be smoother when done automatically. If you omit this parameter or set it to undefined, it's set to true.
// [dithering]: Set this to true if you want the gradient lighting to be dithered. If your textures have banning issues because of the lighting, dithering can make it less noticeable. However, it's
//     a bit slower. If you omit this parameter or set it to undefined, it's set to true.

var instance = instance_create(argument[0], argument[1], obj_ib_book);

with (instance) {
    if (argument_count > 2 && !is_undefined(argument[2])) precision_x = 1 / argument[2]; else precision_x = 1 / 30;
    if (argument_count > 3 && !is_undefined(argument[3])) precision_y = 1 / argument[3]; else precision_y = 1 / 45;
    if (argument_count > 4 && !is_undefined(argument[4])) fade_in_speed = argument[4]; else fade_in_speed = 0.1;
    if (argument_count > 5 && !is_undefined(argument[5])) fade_out_speed = argument[5]; else fade_out_speed = 0.1;
    if (argument_count > 6 && !is_undefined(argument[6])) shadow_color = argument[6]; else shadow_color = $AAAAAA;
    if (argument_count > 7 && !is_undefined(argument[7])) light_source_distance = argument[7]; else light_source_distance = 3;
    if (argument_count > 8 && !is_undefined(argument[8])) shadow_smoothness = max(0.000001, argument[8]); else shadow_smoothness = 0.1;
    if (argument_count > 9 && !is_undefined(argument[9])) gradient_color = argument[9]; else gradient_color = $AAAAAA;
    if (argument_count > 10 && !is_undefined(argument[10])) wave_factor_inner = argument[10]; else wave_factor_inner = 1;
    if (argument_count > 11 && !is_undefined(argument[11])) wave_factor_outer = argument[11]; else wave_factor_outer = 0;
    if (argument_count > 12 && !is_undefined(argument[12])) wave_dependence = argument[12]; else wave_dependence = 0;
    if (argument_count > 13 && !is_undefined(argument[13])) flip_smoothing = argument[13]; else flip_smoothing = true;
    if (argument_count > 14 && !is_undefined(argument[14])) dithering_enabled = argument[14]; else dithering_enabled = true;
    
    map_curved_to_flat_surfaces = ds_map_create();
    view_matrix = matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1);
    projection_matrix = matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1);
    sheet = 0;
    max_sheet_width = -1;
    transition_sheet_target = sheet;
    transition_sheet_first = transition_sheet_target;
    transition_sheet_last = transition_sheet_target - 1;
    transition_speed = 0;
    transition_speed_reduction = true;
    transition_time = 1000;
    sheet_spacing = 1;
    matrix_identity = matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1);
    shadow_color_red = color_get_red(shadow_color) / 255; shadow_color_green = color_get_green(shadow_color) / 255; shadow_color_blue = color_get_blue(shadow_color) / 255;
    gradient_color_red = color_get_red(gradient_color) / 255; gradient_color_green = color_get_green(gradient_color) / 255; gradient_color_blue = color_get_blue(gradient_color) / 255;
    if (dithering_enabled) shader = sh_ib_book_1; else shader = sh_ib_book_0;
    texture_dithering_pattern = sprite_get_texture(spr_ib_dithering_pattern, 0);
    sf_3d = -1;
    scale_x = 1; scale_y = 1;
    
    // Assigns uniform handles.
    uniform_sh_ib_book_1_texture_dithering_pattern = shader_get_sampler_index(sh_ib_book_1, "texture_dithering_pattern");
    uniform_sh_ib_book_uvs = shader_get_uniform(shader, "uvs");
    uniform_sh_ib_book_color = shader_get_uniform(shader, "color");
    uniform_sh_ib_book_shadow_color = shader_get_uniform(shader, "shadow_color");
    uniform_sh_ib_book_shadow_smoothness = shader_get_uniform(shader, "shadow_smoothness");
    uniform_sh_ib_book_wave_factor = shader_get_uniform(shader, "wave_factor");
    uniform_sh_ib_book_precalculated_0 = shader_get_uniform(shader, "precalculated_0");
    uniform_sh_ib_book_precalculated_1 = shader_get_uniform(shader, "precalculated_1");
    uniform_sh_ib_book_precalculated_2 = shader_get_uniform(shader, "precalculated_2");
    uniform_sh_ib_build_curved_to_flat_surface_wave_factor = shader_get_uniform(sh_ib_build_curved_to_flat_surface, "wave_factor");
    uniform_sh_ib_build_curved_to_flat_surface_precalculated = shader_get_uniform(sh_ib_build_curved_to_flat_surface, "precalculated");
        
    // Creates data structures.
    list_sheets = ds_list_create();
    list_sheets_with_special_visibility_type = ds_list_create();
    map_sheet_alpha = ds_map_create();
    priority_depth_sort = ds_priority_create();
    
    // Creates vertex buffers.
    vertex_format_begin(); vertex_format_add_position(); vertex_format_add_textcoord(); vb_format = vertex_format_end();
    vb_front = vertex_create_buffer();
    vertex_begin(vb_front, vb_format);
        for (var t_y = 1; t_y > 0; t_y -= precision_y) for (t_x = 1; t_x > 0; t_x -= precision_x) {
            vertex_position(vb_front, t_x, t_y); vertex_texcoord(vb_front, t_x, t_y);
            vertex_position(vb_front, t_x - precision_x, t_y); vertex_texcoord(vb_front, t_x - precision_x, t_y);
            vertex_position(vb_front, t_x, t_y - precision_y); vertex_texcoord(vb_front, t_x, t_y - precision_y);
            vertex_position(vb_front, t_x, t_y - precision_y); vertex_texcoord(vb_front, t_x, t_y - precision_y);
            vertex_position(vb_front, t_x - precision_x, t_y); vertex_texcoord(vb_front, t_x - precision_x, t_y);
            vertex_position(vb_front, t_x - precision_x, t_y - precision_y); vertex_texcoord(vb_front, t_x - precision_x, t_y - precision_y);
        }
    vertex_end(vb_front);
    vb_back = vertex_create_buffer();
    vertex_begin(vb_back, vb_format);
        for (var t_y = 1; t_y > 0; t_y -= precision_y) for (t_x = 1; t_x > 0; t_x -= precision_x) {
            vertex_position(vb_back, t_x, t_y - precision_y); vertex_texcoord(vb_back, 1 - t_x, t_y - precision_y);
            vertex_position(vb_back, t_x - precision_x, t_y); vertex_texcoord(vb_back, 1 - t_x + precision_x, t_y);
            vertex_position(vb_back, t_x, t_y); vertex_texcoord(vb_back, 1 - t_x, t_y);
            vertex_position(vb_back, t_x - precision_x, t_y - precision_y); vertex_texcoord(vb_back, 1 - t_x + precision_x, t_y - precision_y);
            vertex_position(vb_back, t_x - precision_x, t_y); vertex_texcoord(vb_back, 1 - t_x + precision_x, t_y);
            vertex_position(vb_back, t_x, t_y - precision_y); vertex_texcoord(vb_back, 1 - t_x, t_y - precision_y);
        }
    vertex_end(vb_back);
    vb_edge = vertex_create_buffer();
    vertex_begin(vb_edge, vb_format);
        vertex_position(vb_edge, 0, 0); vertex_texcoord(vb_edge, 0, 0);
        vertex_position(vb_edge, 1, 0); vertex_texcoord(vb_edge, 1, 0);
        vertex_position(vb_edge, 0, 1); vertex_texcoord(vb_edge, 0, 1);
        vertex_position(vb_edge, 0, 1); vertex_texcoord(vb_edge, 0, 1);
        vertex_position(vb_edge, 1, 0); vertex_texcoord(vb_edge, 1, 0);
        vertex_position(vb_edge, 1, 1); vertex_texcoord(vb_edge, 1, 1);
    vertex_end(vb_edge);
}

return instance;
