// Draws the background of the window.
//draw_sprite_tiled(spr_example_background, 0, get_timer() * 0.00002, get_timer() * 0.00001);

// Draws the arrow buttons that let the user navigate the book.
/*
draw_sprite_ext(sprArrow, 0, room_width * 0.5 + 48, room_height - 82, 1, 1, 0, c_white, 1);
draw_sprite_ext(sprArrow, 0, room_width * 0.5 - 48, room_height - 82, -1, 1, 0, c_white, 1);
draw_sprite_ext(sprArrow, 1, room_width * 0.5 + 140, room_height - 82, 1, 1, 0, c_white, 1);
draw_sprite_ext(sprArrow, 1, room_width * 0.5 - 140, room_height - 82, -1, 1, 0, c_white, 1);
*/

// Makes sure the surfaces used by the book exist and are assigned as textures for the sheets that use them.
/// @description  setSurfaces()
//
// Makes sure the surfaces used by the book exist and are assigned as textures for the sheets that use them.
var index, update = false;

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(ft_example_sheet);

// Creates the chapter 1 surfaces if they don't exist:
if (!surface_exists(surfCh1PgTitle)) {
	update = true;
	surfCh1PgTitle = surface_create(sheet_width, sheet_height);
}

if (!surface_exists(surfCh1Pg1)) {
	update = true;
	surfCh1Pg1 = surface_create(sheet_width, sheet_height);
}

// Draws to the ch1 surfaces.
if (ib_sheet_is_visible(sheetCh1PgTitle_1)) {
	surface_set_target(surfCh1PgTitle);
		// Draws a sheet to the surface. Alphablend is disabled so that the blank sheet sprite will replace all pixels in the surface. Then draws the buttons.
		// xstart, ystart is the position entered when the button was created, and since this is the button position relative to the sheet we use it.
		draw_enable_alphablend(false);
			draw_sprite(spr_misc_sheet_front, 0, 0, 0);
		draw_enable_alphablend(true);
	surface_reset_target();

	surface_set_target(surfCh1Pg1);
		// Draws a sheet to the surface. Alphablend is disabled so that the blank sheet sprite will replace all pixels in the surface. Then draws the buttons.
		// xstart, ystart is the position entered when the button was created, and since this is the button position relative to the sheet we use it.
		draw_enable_alphablend(false);
			draw_sprite(spr_misc_sheet_back, 0, 0, 0);
			draw_sprite_ext(objBookBoy.sprite_index, objBookBoy.image_index, playerLocX, playerLocY,
								0.5, 0.5, 0, -1, 1);
			draw_sprite_ext(objBookBlock.sprite_index, objBookBlock.image_index, 10, 
								252 + (sprite_get_height(sprBookBoy) / 4), 11.6, 0.25, 0, -1, 1);
		draw_enable_alphablend(true);
	surface_reset_target();
}

if (!surface_exists(surfCh1Pg2)) {
	update = true;
	surfCh1Pg2 = surface_create(sheet_width, sheet_height);
}

if (!surface_exists(surfCh1Pg3)) {
	update = true;
	surfCh1Pg3 = surface_create(sheet_width, sheet_height);
}

if (ib_sheet_is_visible(sheetCh1Pg2_3)) {
	surface_set_target(surfCh1Pg2);
		// Draws a sheet to the surface. Alphablend is disabled so that the blank sheet sprite will replace all pixels in the surface. Then draws the buttons.
		// xstart, ystart is the position entered when the button was created, and since this is the button position relative to the sheet we use it.
		draw_enable_alphablend(false);
			draw_sprite(spr_example_blank_sheet_front, 0, 0, 0);
			if (hasKey == false) {
				draw_sprite_ext(objKey.sprite_index, objKey.image_index, 50, 252,
									2, 2, 0, -1, 1);
			}
			draw_sprite_ext(objBookBoy.sprite_index, objBookBoy.image_index, playerLocX - sheet_width, playerLocY,
								0.5, 0.5, 0, -1, 1);
			draw_sprite_ext(objBookBlock.sprite_index, objBookBlock.image_index, 10 - sheet_width, 
								252 + (sprite_get_height(sprBookBoy) / 4), 11.6, 0.25, 0, -1, 1);
		draw_enable_alphablend(true);
	surface_reset_target();

	surface_set_target(surfCh1Pg3);
		// Draws a sheet to the surface. Alphablend is disabled so that the blank sheet sprite will replace all pixels in the surface. Then draws the buttons.
		// xstart, ystart is the position entered when the button was created, and since this is the button position relative to the sheet we use it.
		draw_enable_alphablend(false);
			draw_sprite(spr_misc_sheet_back, 1, 0, 0);
			draw_sprite_ext(objBookBoy.sprite_index, objBookBoy.image_index, playerLocX, playerLocY,
								0.5, 0.5, 0, -1, 1);
			draw_sprite_ext(objBookBlock.sprite_index, objBookBlock.image_index, 10, 
								252 + (sprite_get_height(sprBookBoy) / 4), 11.6, 0.25, 0, -1, 1);
		draw_enable_alphablend(true);
	surface_reset_target();
}

if (!surface_exists(surfCh1Pg4)) {
	update = true;
	surfCh1Pg4 = surface_create(sheet_width, sheet_height);
}

if (!surface_exists(surfCh1PgEnd)) {
	update = true;
	surfCh1PgEnd = surface_create(sheet_width, sheet_height);
}

if (ib_sheet_is_visible(sheetCh1Pg4_End)) {
	surface_set_target(surfCh1Pg4);
		// Draws a sheet to the surface. Alphablend is disabled so that the blank sheet sprite will replace all pixels in the surface. Then draws the buttons.
		// xstart, ystart is the position entered when the button was created, and since this is the button position relative to the sheet we use it.
		draw_enable_alphablend(false);
			draw_sprite(spr_example_blank_sheet_front, 0, 0, 0);
			draw_sprite_ext(objDoor.sprite_index, objDoor.image_index, 290, 252 + (sprite_get_height(sprBookBoy) / 4),
								1, 1, 0, -1, 1);
			draw_sprite_ext(objBookBoy.sprite_index, objBookBoy.image_index, playerLocX - sheet_width, playerLocY,
								0.5, 0.5, 0, -1, 1);
			draw_sprite_ext(objBookBlock.sprite_index, objBookBlock.image_index, 10 - sheet_width, 
								252 + (sprite_get_height(sprBookBoy) / 4), 11.6, 0.25, 0, -1, 1);
		draw_enable_alphablend(true);
	surface_reset_target();

	surface_set_target(surfCh1PgEnd);
		// Draws a sheet to the surface. Alphablend is disabled so that the blank sheet sprite will replace all pixels in the surface. Then draws the buttons.
		// xstart, ystart is the position entered when the button was created, and since this is the button position relative to the sheet we use it.
		draw_enable_alphablend(false);
			draw_sprite(spr_misc_sheet_back, 2, 0, 0);
		draw_enable_alphablend(true);
	surface_reset_target();
}

// Creates the chapter 2 surfaces if they don't exist:
if (!surface_exists(surfCh2PgTitle)) {
	update = true;
	surfCh2PgTitle = surface_create(sheet_width, sheet_height);
}

if (!surface_exists(surfCh2Pg1)) {
	update = true;
	surfCh2Pg1 = surface_create(sheet_width, sheet_height);
}

// Draws to the ch2 surfaces.
if (ib_sheet_is_visible(sheetCh2PgTitle_1)) {
	surface_set_target(surfCh2PgTitle);
		// Draws a sheet to the surface. Alphablend is disabled so that the blank sheet sprite will replace all pixels in the surface. Then draws the buttons.
		// xstart, ystart is the position entered when the button was created, and since this is the button position relative to the sheet we use it.
		draw_enable_alphablend(false);
			draw_sprite(spr_misc_sheet_front, 1, 0, 0);
		draw_enable_alphablend(true);
	surface_reset_target();

	surface_set_target(surfCh2Pg1);
		// Draws a sheet to the surface. Alphablend is disabled so that the blank sheet sprite will replace all pixels in the surface. Then draws the buttons.
		// xstart, ystart is the position entered when the button was created, and since this is the button position relative to the sheet we use it.
		draw_enable_alphablend(false);
			draw_sprite(spr_example_blank_sheet_back, 0, 0, 0);
		draw_enable_alphablend(true);
	surface_reset_target();
}

/*
if (!surface_exists(chapter1Sheets[| 0].texture_front)) {
    update = true;
    sf_buttons = surface_create(sheet_width, sheet_height);
}
if (!surface_exists(chapter1Sheets[| 0].texture_back)) {
    update = true;
    sf_buttons = surface_create(sheet_width, sheet_height);
}

if (ib_sheet_is_visible(chapter1Sheets[| 0])) {
	chapter1Sheets[| 0].texture_front = surface_create(sheet_width, sheet_height);
	chapter1Sheets[| 0].texture_back = surface_create(sheet_width, sheet_height);
	if (!instance_exists(objBookBoy)) {
		with (chapter1Sheets[| 0].texture_front) instance_create(50, 112, objBookBoy);	
	}

	surface_set_target(chapter1Sheets[| 0].texture_front);
        // Draws a sheet to the surface. Alphablend is disabled so that the blank sheet sprite will replace all pixels in the surface. Then draws the buttons.
        // xstart, ystart is the position entered when the button was created, and since this is the button position relative to the sheet we use it.
        draw_enable_alphablend(false);
            draw_sprite(spr_example_misc_sheet_front, 7, 0, 0);
        draw_enable_alphablend(true);
    surface_reset_target();
	
	surface_set_target(chapter1Sheets[| 0].texture_back);
        // Draws a sheet to the surface. Alphablend is disabled so that the blank sheet sprite will replace all pixels in the surface. Then draws the buttons.
        // xstart, ystart is the position entered when the button was created, and since this is the button position relative to the sheet we use it.
        draw_enable_alphablend(false);
            draw_sprite(spr_example_misc_sheet_front, 7, 0, 0);
        draw_enable_alphablend(true);
    surface_reset_target();
}
*/

// If a surface was newly created, update is true, and what's below is executed.    
if (update) {
	// Sets the textures for chapter 1 sheets
	ib_sheet_set_texture(sheetCh1PgTitle_1, surface_get_texture(surfCh1PgTitle), surface_get_texture(surfCh1Pg1), sheet_width, sheet_height,
                  undefined, undefined);
				  
	ib_sheet_set_texture(sheetCh1Pg2_3, surface_get_texture(surfCh1Pg2), surface_get_texture(surfCh1Pg3), sheet_width, sheet_height,
                  undefined, undefined);
				  
	ib_sheet_set_texture(sheetCh1Pg4_End, surface_get_texture(surfCh1Pg4), surface_get_texture(surfCh1PgEnd), sheet_width, sheet_height,
                  undefined, undefined);
				  
	// Sets the textures for chapter 2 sheets
	ib_sheet_set_texture(sheetCh2PgTitle_1, surface_get_texture(surfCh2PgTitle), surface_get_texture(surfCh2Pg1), sheet_width, sheet_height,
                  undefined, undefined);
}

// Draws the book.
ib_book_draw(book, room_width, room_height);

// Draws a gradient near the edge of the window.
draw_sprite_stretched(spr_example_gradient, 0, 0, 0, room_width, room_height);
