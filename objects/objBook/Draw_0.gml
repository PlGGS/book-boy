// Draws the background of the window.
//draw_sprite_tiled(spr_example_background, 0, get_timer() * 0.00002, get_timer() * 0.00001);

// Draws the arrow buttons that let the user navigate the book.
draw_sprite_ext(sprArrow, 0, room_width * 0.5 + 48, room_height - 82, 1, 1, 0, c_white, 1);
draw_sprite_ext(sprArrow, 0, room_width * 0.5 - 48, room_height - 82, -1, 1, 0, c_white, 1);
draw_sprite_ext(sprArrow, 1, room_width * 0.5 + 140, room_height - 82, 1, 1, 0, c_white, 1);
draw_sprite_ext(sprArrow, 1, room_width * 0.5 - 140, room_height - 82, -1, 1, 0, c_white, 1);

// Makes sure the surfaces used by the book exist and are assigned as textures for the sheets that use them.
setSurfaces();

// Draws the book.
ib_book_draw(book, room_width, room_height);

// Draws a gradient near the edge of the window.
draw_sprite_stretched(spr_example_gradient, 0, 0, 0, room_width, room_height);

