/// @description  ib_sheet_position_flat_to_curved(sheet instance id, x, y, target width, target height)
/// @param sheet instance id
/// @param  x
/// @param  y
/// @param  target width
/// @param  target height
//
// The sheets in the books can curve outward, making the graphics on the sheets curve outward as well. If you had a rectangle on a flat version of a sheet, it would no longer be a
// rectangle on screen because of the curvature of the sheet. This script takes a position (x, y) on the flat version of the sheet and transforms it to the position it would be
// in the curved version of the sheet. The script returns an array with the first element being the x coordinate and the second element being the y coordinate.
//
// sheet instance id: The instance id of the sheet. Returned by book_add_sheet.
// x, y: The position to transform where (0, 0) is the top left pixel in the flat version of the sheet.
// target width, target height: The size of the target the book is being drawn to. For example room_width and room_height, or view_wview[0] and view_hview[0] (if you're drawing
//     it in a view), or surface_get_width() and surface_get_height() (if you're drawing it to a surface).

var result, t, book = argument0.book, wave_factor_x, wave_factor_y, old_x, old_y, old_z, new_w, world_matrix, matrix, target_width = argument3, target_height = argument4;

// Creates world view projection matrix, and converts pixel coordinates to vertex coordinates.
world_matrix = argument0.matrix;
world_matrix[12] = target_width * 0.5; world_matrix[13] += target_height * 0.5;
matrix = matrix_multiply(world_matrix, matrix_multiply(book.view_matrix, argument0.book.projection_matrix));
old_x = (argument1 - book.x) / book.scale_x / world_matrix[0];
old_y = ((argument2 - book.y) / book.scale_y - argument0.matrix[13]) / world_matrix[5];

// Finds old_z as a function of old_x.
if (argument0.timer < 0) old_x *= -1;
t = (1 - argument0.stiffness_default) * world_matrix[0];
wave_factor_x = book.wave_factor_inner * t; wave_factor_y = book.wave_factor_outer * t * 0.2;
t = 0.25 - power(old_x - 0.5, 2);
if (t >= 0) old_z = sqrt(t) * (1 - old_x) * wave_factor_x + power(old_x, 5) * wave_factor_y; else old_z = 0;
if (argument0.timer < 0) old_x *= -1;

// Transforms the coordinate from flat to curved.
new_w = matrix[11] * old_z + matrix[15];
result[0] = ((matrix[0] * old_x + matrix[12]) / new_w * 0.5 * book.scale_x + 0.5) * target_width + (book.x - target_width * 0.5);
result[1] = ((matrix[5] * old_y + matrix[13]) / new_w * -0.5 * book.scale_y + 0.5) * target_height + (book.y - target_height * 0.5);

return result;
