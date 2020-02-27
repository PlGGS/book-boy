/// @description  ib_sheet_position_curved_to_flat(sheet instance id, x, y, target width, target height)
/// @param sheet instance id
/// @param  x
/// @param  y
/// @param  target width
/// @param  target height
//
// The sheets in the books can curve outward, making the graphics on the sheets curve outward as well. If you had a rectangle on a flat version of a sheet, it would no longer be a
// rectangle on screen because of the curvature of the sheet. This script takes a position (x, y) on the curved version of the sheet and transforms it to the position it would be
// in the flat version of the sheet. This means you can e.g. check if your mouse position is within a box in the flat version of the sheet even though it's curved. This is done
// by passing in the mouse position relative to the sheet on screen (with (0, 0) being the top left pixel in the sheet) and then checking if it's within the box on the flat sheet.
// There's a detailed example provided together with this asset which shows you how to do this. The script returns an array with the first element being the x coordinate and the
// second element being the y coordinate. If the coordinate is outside the book, the array's elements will both be -1.
//
// sheet instance id: The instance id of the sheet. Returned by book_add_sheet.
// x, y: The position to transform where (0, 0) is the top left pixel in the curved version of the sheet.
// target width, target height: The size of the target the book is being drawn to. For example room_width and room_height, or view_wport[0] and view_hport[0] (if you're drawing
//     it in a view), or surface_get_width() and surface_get_height() (if you're drawing it to a surface).

var sheet = argument0, result, t, matrix = sheet.matrix, matrix_small, book = sheet.book, buffer, t_x, t_y, target_width = argument3, target_height = argument4, sf, sf_width = target_width, sf_height = target_height,
    sheet_small_width = sheet.matrix[0], sheet_small_height = sheet.matrix[5];

with (book) {
    matrix_small = matrix_build(sf_width * 0.5, sf_height * 0.5 - sheet_small_height * 0.5, 0, 0, 0, 0, sheet_small_width, sheet_small_height, 1);

    t = (1 - sheet.stiffness_default) * matrix_small[0];
    var key = string(sheet_small_width) + "," + string(sheet_small_height) + "," + string(target_width) + "," + string(target_height) + "," + string_format(wave_factor_inner * t, 0, 6) + "," + string_format(wave_factor_outer * t * 0.2, 0, 6);

    // Creates a lookup table if it doesn't already exist.
    if (!ds_map_exists(map_curved_to_flat_surfaces, key)) {
        while (ds_map_size(map_curved_to_flat_surfaces) > 8) {
            t = ds_map_find_first(map_curved_to_flat_surfaces);
            buffer_delete(map_curved_to_flat_surfaces[? t]);
            ds_map_delete(map_curved_to_flat_surfaces, t);
        }

        sf = surface_create(sf_width, sf_height);
        
        surface_set_target(sf);
            shader_set(sh_ib_build_curved_to_flat_surface);
                draw_clear(c_black);
    
                d3d_start();
                    var distance_from_book = sf_width * 1.5, t_x = sf_width * 0.5 + 0.5, t_y = sf_height * 0.5 + 0.5, near, far;
                    near = distance_from_book - max_sheet_width; far = distance_from_book + 1;
                    d3d_set_projection_ext(t_x, t_y, distance_from_book, t_x, t_y, 0, 0, -1, 0, darctan((sf_height * 0.5) / distance_from_book) * 2, sf_width / sf_height, near, far);
                    d3d_set_hidden(false);
                    d3d_set_culling(false);
    
                    matrix_set(matrix_world, matrix_small);
                    t = (1 - sheet.wave_factor) * matrix_small[0];
                    shader_set_uniform_f(uniform_sh_ib_build_curved_to_flat_surface_wave_factor, wave_factor_inner * t, wave_factor_outer * t * 0.2);
                    
                    shader_set_uniform_f(uniform_sh_ib_build_curved_to_flat_surface_precalculated, 1);
                    vertex_submit(vb_front, pr_trianglelist, -1);
                    
                    shader_set_uniform_f(uniform_sh_ib_build_curved_to_flat_surface_precalculated, -1);                    
                    vertex_submit(vb_back, pr_trianglelist, -1);
                        
                    matrix_set(matrix_world, matrix_identity);
                d3d_end();
            shader_reset();
        surface_reset_target();
        
        buffer = buffer_create(sf_width * sf_height * 4, buffer_fixed, 1);
        buffer_get_surface(buffer, sf, 0, 0, 0);
        map_curved_to_flat_surfaces[? key] = buffer;
        
        surface_free(sf);
    }
    
    // Uses a lookup table to do the inverse transformation.
    buffer = book.map_curved_to_flat_surfaces[? key];
    t_x = round((argument1 - book.x) / matrix[0] * sheet_small_width / scale_x + sf_width * 0.5);
    t_y = round((argument2 - book.y) / matrix[5] * sheet_small_height / scale_y + sf_height * 0.5);
    
    if (t_x < 0 || t_y < 0 || t_x >= sf_width || t_y >= sf_height) {
        result[0] = -1;
        result[1] = -1;
    } else {
        t = (sf_width * t_y + t_x) * 4;
        t_x = buffer_peek(buffer, t, buffer_u8);
        t_y = buffer_peek(buffer, t + 1, buffer_u8);
        
        if (t_x == 0 && t_y == 0) {
            result[0] = -1;
            result[1] = -1;
        } else {
            result[0] = book.x + (t_x / 255 * 2 - 1) * matrix[0];
            result[1] = book.y + (t_y / 255) * matrix[5];
        }
    }
    
    return result;
}
