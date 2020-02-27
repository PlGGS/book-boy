/// @description  ib_book_draw(book instance id, target width, target height)
/// @param book instance id
/// @param  target width
/// @param  target height
//
// Draws the book to screen.
//
// book instance id: The instance id of the book. Returned at book creation.
// target width, target height: The size of the target the book is being drawn to. For example room_width and room_height, or view_wview[0] and view_hview[0] (if you're drawing
//     it in a view), or surface_get_width() and surface_get_height() (if you're drawing it to a surface).

with (argument0) {
    global.__ib_target_width = argument1;
    global.__ib_target_height = argument2;
    event_perform(ev_draw, 0);
}
