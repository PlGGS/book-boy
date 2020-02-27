var instance, instance_previous, instance_next, uvs, i, j, t, matrix, count, sheets = ds_list_size(list_sheets), sheet_last = sheets - 1, key_last, wave_factor_max, wave_factor_speed_delta_timed, wave_factor_speed_delta_timed_1;

if (flip_smoothing) {wave_factor_speed_delta_timed = power(0.2, delta_time / (1000000 / 60)); wave_factor_speed_delta_timed_1 = power(0.3, delta_time / (1000000 / 60));}
else {wave_factor_speed_delta_timed = power(0.3, delta_time / (1000000 / 60)); wave_factor_speed_delta_timed_1 = power(0.15, delta_time / (1000000 / 60));}

// Adds sheets that are fading out to the draw priority.
i = ds_map_find_first(map_sheet_alpha); key_last = ds_map_find_last(map_sheet_alpha);
j = 0;
if (ds_map_size(map_sheet_alpha)) while (true) {
    t = map_sheet_alpha[? i];
    if (t > 1) t -= fade_in_speed * (delta_time / (1000000 / 60)); else t -= fade_out_speed * (delta_time / (1000000 / 60));
    if (t <= 0) delete[j++] = i;
    else {
        ds_priority_add(priority_depth_sort, i, 2 + lerp(i, sheet_last - i, list_sheets[| i].timer < 0) / sheets);
        added_to_priority_depth_sort[i] = true;
    }
    if (set_to_opaque) t = 1;
    map_sheet_alpha[? i] = t;
    if (i == key_last) break;
    i = ds_map_find_next(map_sheet_alpha, i);
}
for (i = 0; i < j; ++i) ds_map_delete(map_sheet_alpha, delete[i]);

if (window_get_width() == 0 || os_is_paused()) set_to_opaque = 5;

if (set_to_opaque >= 1) {
    if (ds_map_size(map_sheet_alpha)) while (true) {
        map_sheet_alpha[? i] = 1;
        if (i == key_last) break;
        i = ds_map_find_next(map_sheet_alpha, i);
    }
    set_to_opaque -= 1;
}

// Adds still sheets to the left to the draw priority.
if (transition_sheet_first >= 1 && transition_sheet_first <= sheet_last && list_sheets[| transition_sheet_first].timer < -0.75) wave_factor_max = lerp(list_sheets[| transition_sheet_first].stiffness_default, 1, wave_dependence * lerp(transition_sheet_first, sheet_last - transition_sheet_first, list_sheets[| transition_sheet_first].timer < 0) / sheet_last); else wave_factor_max = 0;
for (i = transition_sheet_first - 1; i >= 0; --i) {
    instance = list_sheets[| i];
    if (!added_to_priority_depth_sort[i]) {ds_priority_add(priority_depth_sort, i, 2 + lerp(i, sheet_last - i, instance.timer < 0) / sheets); added_to_priority_depth_sort[i] = true;}
    if (ds_map_exists(map_sheet_alpha, i)) map_sheet_alpha[? i] = max(1, map_sheet_alpha[? i]); else map_sheet_alpha[? i] = 2;
    t = lerp(instance.stiffness_default, 1, wave_dependence * lerp(i, sheet_last - i, instance.timer < 0) / sheet_last);
    if (t > wave_factor_max) wave_factor_max = t;
    if (instance.wave_factor < wave_factor_max) instance.wave_factor += (wave_factor_max - instance.wave_factor) * wave_factor_speed_delta_timed_1; else instance.wave_factor += (wave_factor_max - instance.wave_factor) * wave_factor_speed_delta_timed;
    if (!instance.transparent) break;
}

// Adds still sheets to the right to the draw priority.
if (transition_sheet_last >= 0 && transition_sheet_last <= sheet_last - 1 && list_sheets[| transition_sheet_last].timer > 0.75) wave_factor_max = lerp(list_sheets[| transition_sheet_last].stiffness_default, 1, wave_dependence * lerp(transition_sheet_last, sheet_last - transition_sheet_last, list_sheets[| transition_sheet_last].timer < 0) / sheet_last); else wave_factor_max = 0;
for (i = transition_sheet_last + 1; i <= sheet_last; ++i) {
    instance = list_sheets[| i];
    if (!added_to_priority_depth_sort[i]) {ds_priority_add(priority_depth_sort, i, 2 + lerp(i, sheet_last - i, instance.timer < 0) / sheets); added_to_priority_depth_sort[i] = true;}
    if (ds_map_exists(map_sheet_alpha, i)) map_sheet_alpha[? i] = max(1, map_sheet_alpha[? i]); else map_sheet_alpha[? i] = 2;
    t = lerp(instance.stiffness_default, 1, wave_dependence * lerp(i, sheet_last - i, instance.timer < 0) / sheet_last);
    if (t > wave_factor_max) wave_factor_max = t;
    if (instance.wave_factor < wave_factor_max) instance.wave_factor += (wave_factor_max - instance.wave_factor) * wave_factor_speed_delta_timed_1; else instance.wave_factor += (wave_factor_max - instance.wave_factor) * wave_factor_speed_delta_timed;
    if (!instance.transparent) break;
}

// Adds moving sheets to the draw priority.
for (i = transition_sheet_first; i <= transition_sheet_last; ++i) {
    instance = list_sheets[| i];
    if (abs(instance.timer) == 1) t = 2 + lerp(i, sheet_last - i, instance.timer < 0) / sheets; else t = abs(instance.timer) + lerp(i, sheet_last - i, instance.timer < 0) / sheets * 0.000001;
    if (added_to_priority_depth_sort[i]) ds_priority_change_priority(priority_depth_sort, i, t);
    else {ds_priority_add(priority_depth_sort, i, t); added_to_priority_depth_sort[i] = true;}
    if (ds_map_exists(map_sheet_alpha, i)) map_sheet_alpha[? i] = max(1, map_sheet_alpha[? i]); else map_sheet_alpha[? i] = 2;
    instance.wave_factor += (lerp(instance.stiffness_default, 1, wave_dependence * lerp(i, sheet_last - i, instance.timer < 0) / sheet_last) - instance.wave_factor) * wave_factor_speed_delta_timed_1;
}

// Adds special visibility type sheets to the draw priority.
for (j = ds_list_size(list_sheets_with_special_visibility_type) - 1; j >= 0; --j) {
    i = list_sheets_with_special_visibility_type[| j];
    instance = list_sheets[| i];
    if (instance.visibility_type != 2 || ((i != 0 || sheet != sheets || list_sheets[| sheet_last].timer != -1) && (i != sheet_last || sheet != 0 || list_sheets[| 0].timer != 1))) {
        if (!added_to_priority_depth_sort[i]) ds_priority_add(priority_depth_sort, i, 2 + lerp(i, sheet_last - i, instance.timer < 0) / sheets);
        if (ds_map_exists(map_sheet_alpha, i)) map_sheet_alpha[? i] = max(1, map_sheet_alpha[? i]); else map_sheet_alpha[? i] = 2;
    }
}

var target_width = global.__ib_target_width, target_height = global.__ib_target_height;

if (surface_exists(sf_3d)) {
    if (target_width != surface_get_width(sf_3d) || target_height != surface_get_height(sf_3d)) surface_free(sf_3d);
}

if (!surface_exists(sf_3d)) sf_3d = surface_create(target_width, target_height);

draw_set_alpha_test(true);
draw_set_blend_mode_ext(bm_one, bm_inv_src_alpha);
    surface_set_target(sf_3d);
        draw_clear_alpha(c_black, 0);
    
        d3d_start();
            var distance_from_book = target_width * 1.5, t_x = target_width * 0.5 + 0.5, t_y = target_height * 0.5 + 0.5, near, far, hidden = false, alpha;
            near = distance_from_book - max_sheet_width; far = distance_from_book + 1;
            d3d_set_projection_ext(t_x, t_y, distance_from_book, t_x, t_y, 0, 0, -1, 0, darctan((target_height * 0.5) / distance_from_book) * 2, target_width / target_height, near, far);
            view_matrix = matrix_get(matrix_view);
            projection_matrix = matrix_get(matrix_projection);
            d3d_set_hidden(false);
            d3d_set_culling(true);
                shader_set(shader);
                    
                    if (shader == sh_ib_book_1) {
                        texture_set_repeat_ext(uniform_sh_ib_book_1_texture_dithering_pattern, true);
                        texture_set_stage(uniform_sh_ib_book_1_texture_dithering_pattern, texture_dithering_pattern);
                    }
                    
                    repeat (ds_priority_size(priority_depth_sort)) {
                        i = ds_priority_delete_max(priority_depth_sort);
                        instance = list_sheets[| i];
                        instance_previous = list_sheets[| i - 1];
                        instance_next = list_sheets[| i + 1];
                        
                        var l_z = light_source_distance, angle, a_x, a_z, s_x, s_z, blend_factor, stiffness, flip_direction;
                        if (flip_smoothing) angle = ib_smoothstep(0.5 - instance.timer * 0.5) * pi; else angle = (0.5 - instance.timer * 0.5) * pi;
                        a_x = cos(angle); a_z = sin(angle);
                        t = true;
                        if (angle > pi * 0.5) {
                            if (i == sheet_last) t = false;
                            else {
                                if (flip_smoothing) angle = ib_smoothstep(0.5 - instance_next.timer * 0.5) * pi; else angle = (0.5 - instance_next.timer * 0.5) * pi;
                                if (angle < pi * 0.5) t = false; else {s_x = cos(angle); s_z = sin(angle);}
                            }
                        } else {
                            if (i == 0) t = false;
                            else {
                                if (flip_smoothing) angle = ib_smoothstep(0.5 - instance_previous.timer * 0.5) * pi; else angle = (0.5 - instance_previous.timer * 0.5) * pi;
                                if (angle > pi * 0.5) t = false; else {s_x = cos(angle); s_z = sin(angle);}
                            }
                        }
                        if (t) {
                            shader_set_uniform_f(uniform_sh_ib_book_shadow_color, shadow_color_red, shadow_color_green, shadow_color_blue);
                            shader_set_uniform_f(uniform_sh_ib_book_shadow_smoothness, shadow_smoothness);
                            shader_set_uniform_f(uniform_sh_ib_book_precalculated_1, shadow_smoothness * 0.5 - abs(l_z / (a_z / a_x - (s_z - l_z) / s_x)));
                        } else shader_set_uniform_f(uniform_sh_ib_book_shadow_color, 1, 1, 1);
                        
                        alpha = ib_smoothstep(1 - abs(map_sheet_alpha[? i] - 1));
                        
                        if (instance.origin_x != 0) {
                            blend_factor = 0;
                            stiffness = 1;
                            flip_direction = 1;
                            shader_set_uniform_f(uniform_sh_ib_book_color, 1, 1, 1, alpha);
                            shader_set_uniform_f(uniform_sh_ib_book_wave_factor, 0);
                            shader_set_uniform_f(uniform_sh_ib_book_precalculated_0, sin(blend_factor * pi) * (1 - stiffness) * 1.4, cos(blend_factor * pi), sin(blend_factor * pi) * (1 - stiffness) * 0.4 * flip_direction, sin(blend_factor * pi) * instance.matrix[0] * (0.5 + stiffness * 0.5));
                            shader_set_uniform_f(uniform_sh_ib_book_precalculated_2, 1);
                            if (i < sheet_last * 0.5) {
                                matrix = instance.matrix_front_edge;
                                matrix[12] += target_width * 0.5; matrix[13] += target_height * 0.5;
                                matrix_set(matrix_world, matrix);
                                uvs = instance.uvs_front_edge;
                                shader_set_uniform_f(uniform_sh_ib_book_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
                                vertex_submit(vb_edge, pr_trianglelist, instance.texture_front);
                            } else {
                                d3d_set_culling(false);
                                matrix = instance.matrix_back_edge;
                                matrix[12] += target_width * 0.5; matrix[13] += target_height * 0.5;
                                matrix_set(matrix_world, matrix);
                                uvs = instance.uvs_back_edge;
                                shader_set_uniform_f(uniform_sh_ib_book_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
                                vertex_submit(vb_edge, pr_trianglelist, instance.texture_back);
                                d3d_set_culling(true);
                            }
                        }
                        
                        matrix = instance.matrix;
                        matrix[12] = target_width * 0.5; matrix[13] += target_height * 0.5;
                        
                        if (!hidden && abs(instance.timer) < 0.3) {d3d_set_hidden(true); hidden = true;}
                        added_to_priority_depth_sort[i] = false;
                        matrix_set(matrix_world, matrix);
                        stiffness = lerp(1, instance.stiffness, abs(instance.flip_direction));
                        flip_direction = -sign(instance.flip_direction);
                        t = (1 - instance.wave_factor) * power(abs(instance.timer), 0.1) * matrix[0];
                        shader_set_uniform_f(uniform_sh_ib_book_wave_factor, wave_factor_inner * t, wave_factor_outer * t * 0.2);
                        
                        if (instance.thickness == 0 || instance.timer == -1 || instance.timer == 1) {
                            if (flip_smoothing) blend_factor = ib_smoothstep(0.5 - instance.timer * 0.5); else blend_factor = 0.5 - instance.timer * 0.5;
                            shader_set_uniform_f(uniform_sh_ib_book_precalculated_0, sin(blend_factor * pi) * (1 - stiffness) * 1.4, cos(blend_factor * pi), sin(blend_factor * pi) * (1 - stiffness) * 0.4 * flip_direction, sin(blend_factor * pi) * matrix[0] * (0.5 + stiffness * 0.5));
                            shader_set_uniform_f(uniform_sh_ib_book_precalculated_2, 1 - clamp((blend_factor * 2 - 1) * 3 * flip_direction, 0, 0.9));
                            if (instance.flip_direction < 0) {
                                if (instance.timer > -1) {
                                    if (i == 0) shader_set_uniform_f(uniform_sh_ib_book_color, 1, 1, 1, alpha); else shader_set_uniform_f(uniform_sh_ib_book_color, gradient_color_red, gradient_color_green, gradient_color_blue, alpha);
                                    uvs = instance.uvs_front;
                                    shader_set_uniform_f(uniform_sh_ib_book_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
                                    vertex_submit(vb_front, pr_trianglelist, instance.texture_front);
                                }
                                if (instance.timer < 1) {
                                    if (i == sheet_last) shader_set_uniform_f(uniform_sh_ib_book_color, 1, 1, 1, alpha); else shader_set_uniform_f(uniform_sh_ib_book_color, gradient_color_red, gradient_color_green, gradient_color_blue, alpha);
                                    uvs = instance.uvs_back;
                                    shader_set_uniform_f(uniform_sh_ib_book_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
                                    vertex_submit(vb_back, pr_trianglelist, instance.texture_back);
                                }
                            } else {
                                if (instance.timer < 1) {
                                    if (i == sheet_last) shader_set_uniform_f(uniform_sh_ib_book_color, 1, 1, 1, alpha); else shader_set_uniform_f(uniform_sh_ib_book_color, gradient_color_red, gradient_color_green, gradient_color_blue, alpha);
                                    uvs = instance.uvs_back;
                                    shader_set_uniform_f(uniform_sh_ib_book_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
                                    vertex_submit(vb_back, pr_trianglelist, instance.texture_back);
                                }
                                if (instance.timer > -1) {
                                    if (i == 0) shader_set_uniform_f(uniform_sh_ib_book_color, 1, 1, 1, alpha); else shader_set_uniform_f(uniform_sh_ib_book_color, gradient_color_red, gradient_color_green, gradient_color_blue, alpha);
                                    uvs = instance.uvs_front;
                                    shader_set_uniform_f(uniform_sh_ib_book_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
                                    vertex_submit(vb_front, pr_trianglelist, instance.texture_front);
                                }
                            }
                        } else {
                            count = instance.thickness;
                            t = instance.thickness_precision * (1 - abs(instance.timer));
                            for (j = instance.timer + instance.thickness * 0.5 * t; j >= 0; j -= t) {
                                if (count-- < 0) break;
                                if (flip_smoothing) blend_factor = ib_smoothstep(0.5 - j * 0.5); else blend_factor = 0.5 - j * 0.5;
                                shader_set_uniform_f(uniform_sh_ib_book_precalculated_0, sin(blend_factor * pi) * (1 - stiffness) * 1.4, cos(blend_factor * pi), sin(blend_factor * pi) * (1 - stiffness) * 0.4 * flip_direction, sin(blend_factor * pi) * matrix[0] * (0.5 + stiffness * 0.5));
                                shader_set_uniform_f(uniform_sh_ib_book_precalculated_2, 1 - clamp((blend_factor * 2 - 1) * 3 * flip_direction, 0, 0.9));
                                if (instance.flip_direction < 0) {
                                    if (instance.timer > -1) {
                                    if (i == 0) shader_set_uniform_f(uniform_sh_ib_book_color, 1, 1, 1, alpha); else shader_set_uniform_f(uniform_sh_ib_book_color, gradient_color_red, gradient_color_green, gradient_color_blue, alpha);
                                        uvs = instance.uvs_front;
                                        shader_set_uniform_f(uniform_sh_ib_book_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
                                        vertex_submit(vb_front, pr_trianglelist, instance.texture_front);
                                    }
                                    if (instance.timer < 1) {
                                    if (i == sheet_last) shader_set_uniform_f(uniform_sh_ib_book_color, 1, 1, 1, alpha); else shader_set_uniform_f(uniform_sh_ib_book_color, gradient_color_red, gradient_color_green, gradient_color_blue, alpha);
                                        uvs = instance.uvs_back;
                                        shader_set_uniform_f(uniform_sh_ib_book_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
                                        vertex_submit(vb_back, pr_trianglelist, instance.texture_back);
                                    }
                                } else {
                                    if (instance.timer < 1) {
                                    if (i == sheet_last) shader_set_uniform_f(uniform_sh_ib_book_color, 1, 1, 1, alpha); else shader_set_uniform_f(uniform_sh_ib_book_color, gradient_color_red, gradient_color_green, gradient_color_blue, alpha);
                                        uvs = instance.uvs_back;
                                        shader_set_uniform_f(uniform_sh_ib_book_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
                                        vertex_submit(vb_back, pr_trianglelist, instance.texture_back);
                                    }
                                    if (instance.timer > -1) {
                                    if (i == 0) shader_set_uniform_f(uniform_sh_ib_book_color, 1, 1, 1, alpha); else shader_set_uniform_f(uniform_sh_ib_book_color, gradient_color_red, gradient_color_green, gradient_color_blue, alpha);
                                        uvs = instance.uvs_front;
                                        shader_set_uniform_f(uniform_sh_ib_book_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
                                        vertex_submit(vb_front, pr_trianglelist, instance.texture_front);
                                    }
                                }
                            }
                            for (j = instance.timer - instance.thickness * 0.5 * t; j < 0; j += t) {
                                if (count-- < 0) break;
                                if (flip_smoothing) blend_factor = ib_smoothstep(0.5 - j * 0.5); else blend_factor = 0.5 - j * 0.5;
                                shader_set_uniform_f(uniform_sh_ib_book_precalculated_0, sin(blend_factor * pi) * (1 - stiffness) * 1.4, cos(blend_factor * pi), sin(blend_factor * pi) * (1 - stiffness) * 0.4 * flip_direction, sin(blend_factor * pi) * matrix[0] * (0.5 + stiffness * 0.5));
                                shader_set_uniform_f(uniform_sh_ib_book_precalculated_2, 1 - clamp((blend_factor * 2 - 1) * 3 * flip_direction, 0, 0.9));
                                if (instance.flip_direction < 0) {
                                    if (instance.timer > -1) {
                                    if (i == 0) shader_set_uniform_f(uniform_sh_ib_book_color, 1, 1, 1, alpha); else shader_set_uniform_f(uniform_sh_ib_book_color, gradient_color_red, gradient_color_green, gradient_color_blue, alpha);
                                        uvs = instance.uvs_front;
                                        shader_set_uniform_f(uniform_sh_ib_book_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
                                        vertex_submit(vb_front, pr_trianglelist, instance.texture_front);
                                    }
                                    if (instance.timer < 1) {
                                    if (i == sheet_last) shader_set_uniform_f(uniform_sh_ib_book_color, 1, 1, 1, alpha); else shader_set_uniform_f(uniform_sh_ib_book_color, gradient_color_red, gradient_color_green, gradient_color_blue, alpha);
                                        uvs = instance.uvs_back;
                                        shader_set_uniform_f(uniform_sh_ib_book_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
                                        vertex_submit(vb_back, pr_trianglelist, instance.texture_back);
                                    }
                                } else {
                                    if (instance.timer < 1) {
                                    if (i == sheet_last) shader_set_uniform_f(uniform_sh_ib_book_color, 1, 1, 1, alpha); else shader_set_uniform_f(uniform_sh_ib_book_color, gradient_color_red, gradient_color_green, gradient_color_blue, alpha);
                                        uvs = instance.uvs_back;
                                        shader_set_uniform_f(uniform_sh_ib_book_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
                                        vertex_submit(vb_back, pr_trianglelist, instance.texture_back);
                                    }
                                    if (instance.timer > -1) {
                                    if (i == 0) shader_set_uniform_f(uniform_sh_ib_book_color, 1, 1, 1, alpha); else shader_set_uniform_f(uniform_sh_ib_book_color, gradient_color_red, gradient_color_green, gradient_color_blue, alpha);
                                        uvs = instance.uvs_front;
                                        shader_set_uniform_f(uniform_sh_ib_book_uvs, uvs[0], uvs[1], uvs[2], uvs[3]);
                                        vertex_submit(vb_front, pr_trianglelist, instance.texture_front);
                                    }
                                }
                            }
                        }
                    }
                    
                shader_reset();
                matrix_set(matrix_world, matrix_identity);
            d3d_set_culling(false);
        d3d_end();
    surface_reset_target();

    draw_surface_ext(sf_3d, x - target_width * 0.5 * scale_x, y - target_height * 0.5 * scale_y, scale_x, scale_y, 0, c_white, 1);
draw_set_blend_mode(bm_normal);
draw_set_alpha_test(false);

