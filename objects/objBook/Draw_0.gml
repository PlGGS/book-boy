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

draw_set_halign(fa_left); draw_set_valign(fa_top); draw_set_font(ft_example_sheet);


// Loops through each text surface used as a front texture for the sheets, and creates and draws them if they don't exist.
/*
for (var i = 0; i < array_length_1d(sf_text_front); ++i) {
    if (!surface_exists(sf_text_front[i])) {
        update = true;
        sf_text_front[i] = surface_create(width, height);
        surface_set_target(sf_text_front[i]);
            
            // Draws a blank sheet to the surface. Alphablend is disabled so that the blank sheet sprite will replace all pixels in the surface.
            draw_enable_alphablend(false);
                draw_sprite(spr_example_blank_sheet_front, i, 0, 0);
            draw_enable_alphablend(true);
            
            // Draws text to the surface. We disable the alpha channel to avoid changing the opacity of the surface.
            draw_set_color_write_enable(true, true, true, false);
                draw_set_color(c_black);
                draw_set_alpha(0.5); draw_text_ext(32, 32, string_hash_to_newline(sf_text_string[i]), -1, width - 64); draw_set_alpha(1);
            draw_set_color_write_enable(true, true, true, true);
            
        surface_reset_target();
    }
}
*/

// Loops through each text surface used as a back texture for the sheets, and creates and draws them if they don't exist.
/*
for (var i = 0; i < array_length_1d(sf_text_back); ++i) {
    if (!surface_exists(sf_text_back[i])) {
        update = true;
        sf_text_back[i] = surface_create(width, height);
        surface_set_target(sf_text_back[i]);
        
            // Draws a blank sheet to the surface. Alphablend is disabled so that the blank sheet sprite will replace all pixels in the surface.
            draw_enable_alphablend(false);
                draw_sprite(spr_example_blank_sheet_back, i, 0, 0);
            draw_enable_alphablend(true);
            
            // Draws text to the surface. We disable the alpha channel to avoid changing the opacity of the surface.
            draw_set_color_write_enable(true, true, true, false);
                draw_set_color(c_black);
                draw_set_alpha(0.5); draw_text_ext(32, 32, string_hash_to_newline(sf_text_string[i]), -1, width - 64); draw_set_alpha(1);
            draw_set_color_write_enable(true, true, true, true);
            
        surface_reset_target();
    }
}
*/

// Creates the chapter 1 surfaces if they don't exist:
if (!surface_exists(srfTest)) {
    update = true;
    srfTest = surface_create(sheet_width, sheet_height);
}

// Draws to the ch1 pg1 surface.
if (ib_sheet_is_visible(shtTest)) {
    surface_set_target(srfTest);
        // Draws a sheet to the surface. Alphablend is disabled so that the blank sheet sprite will replace all pixels in the surface. Then draws the buttons.
        // xstart, ystart is the position entered when the button was created, and since this is the button position relative to the sheet we use it.
        draw_enable_alphablend(false);
			draw_sprite(spr_example_blank_sheet_front, 0, 0, 0);
            draw_sprite(sprPlayer, 0, playerLocX, playerLocY);
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

// Creates the button surface if it doesn't exist:
if (!surface_exists(sf_buttons)) {
    update = true;
    sf_buttons = surface_create(sheet_width, sheet_height);
}

// Draws to the button surface.
if (ib_sheet_is_visible(sheet_buttons)) {
    surface_set_target(sf_buttons);
        // Draws a sheet to the surface. Alphablend is disabled so that the blank sheet sprite will replace all pixels in the surface. Then draws the buttons.
        // xstart, ystart is the position entered when the button was created, and since this is the button position relative to the sheet we use it.
        draw_enable_alphablend(false);
            draw_sprite(spr_example_misc_sheet_front, 7, 0, 0);
            with (objBookButton) draw_sprite(sprite_index, image_index, xstart, ystart);
        draw_enable_alphablend(true);
    surface_reset_target();
}

// Creates the text input field surface if it doesn't exist:
if (!surface_exists(sf_input_field)) {
    update = true;
    sf_input_field = surface_create(sheet_width, sheet_height);
}

// Draws to the text input field surface if that sheet is currently visible to the player.
if (ib_sheet_is_visible(sheet_input_field)) {
    surface_set_target(sf_input_field);
        
        // Draws a sheet to the surface. Alphablend is disabled so that the blank sheet sprite will replace all pixels in the surface.
        draw_enable_alphablend(false);
            draw_sprite(spr_example_misc_sheet_front, 10, 0, 0);
        draw_enable_alphablend(true);
        
        // Draws text to the surface. We disable the alpha channel to avoid changing the opacity of the surface.
        draw_set_color_write_enable(true, true, true, false);
            draw_set_color(c_black);
            keyboard_string = string_copy(keyboard_string, 1, 270);
            draw_set_alpha(0.5); draw_text_ext(70, 165, string_hash_to_newline(keyboard_string), -1, sheet_width - 145); draw_set_alpha(1);
        draw_set_color_write_enable(true, true, true, true);
        
    surface_reset_target();
}

// If a surface was newly created, update is true, and what's below is executed.    
if (update) {
	// Sets the textures for chapter 1 sheets.
	ib_sheet_set_texture(shtTest, surface_get_texture(srfTest), sprite_get_texture(spr_example_blank_sheet_back, 0),
                              undefined, undefined, undefined, sprite_get_uvs(spr_example_blank_sheet_back, 0));
	
	/*
	for (var i = 0; i < ds_list_size(chapter1Sheets); i++) {
		ib_sheet_set_texture(sheet_buttons, surface_get_texture(chapter1Sheets[| i].texture_front), surface_get_texture(chapter1Sheets[| i].texture_back));
	}
	*/
	
    // Sets the textures for the button sheet.
    ib_sheet_set_texture(sheet_buttons, surface_get_texture(sf_buttons), sprite_get_texture(spr_example_blank_sheet_back, 0),
                              undefined, undefined, undefined, sprite_get_uvs(spr_example_blank_sheet_back, 0));
                              
    // Sets the textures for the text input field sheet.
    ib_sheet_set_texture(sheet_input_field, surface_get_texture(sf_input_field), sprite_get_texture(spr_example_blank_sheet_back, 0),
                              undefined, undefined, undefined, sprite_get_uvs(spr_example_blank_sheet_back, 0));
}


// Draws the book.
ib_book_draw(book, room_width, room_height);

// Draws a gradient near the edge of the window.
//draw_sprite_stretched(spr_example_gradient, 0, 0, 0, room_width, room_height);
