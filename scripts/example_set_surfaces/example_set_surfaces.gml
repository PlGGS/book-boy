/// @description  example_create_surfaces()
//
// Makes sure the surfaces used by the book exist and are assigned as textures for the sheets that use them.

var width, height, index, update = false;

draw_set_halign(fa_left); draw_set_valign(fa_top); draw_set_font(ft_example_sheet);
width = sprite_get_width(spr_example_blank_sheet_front); height = sprite_get_height(spr_example_blank_sheet_front);

// Loops through each text surface used as a front texture for the sheets, and creates and draws them if they don't exist.
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

// Loops through each text surface used as a back texture for the sheets, and creates and draws them if they don't exist.
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

// Creates the button surface if it doesn't exist:
if (!surface_exists(sf_buttons)) {
    update = true;
    sf_buttons = surface_create(width, height);
}

// Draws to the button surface.
if (ib_sheet_is_visible(sheet_buttons)) {
    surface_set_target(sf_buttons);
        // Draws a sheet to the surface. Alphablend is disabled so that the blank sheet sprite will replace all pixels in the surface. Then draws the buttons.
        // xstart, ystart is the position entered when the button was created, and since this is the button position relative to the sheet we use it.
        draw_enable_alphablend(false);
            draw_sprite(spr_example_misc_sheet_front, 7, 0, 0);
            with (obj_example_button) draw_sprite(sprite_index, image_index, xstart, ystart);
        draw_enable_alphablend(true);
    surface_reset_target();
}

// Creates the text input field surface if it doesn't exist:
if (!surface_exists(sf_input_field)) {
    update = true;
    sf_input_field = surface_create(width, height);
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
            draw_set_alpha(0.5); draw_text_ext(70, 165, string_hash_to_newline(keyboard_string), -1, width - 145); draw_set_alpha(1);
        draw_set_color_write_enable(true, true, true, true);
        
    surface_reset_target();
}

// If a surface was newly created, update is true, and what's below is executed.    
if (update) {
    // Loops through all the sheets that are dependent on the text surfaces and sets their texture.
    // We set a random seed so that we use the same random order of sheets if the surfaces spontaneously disappear.
    random_set_seed(0);
    for (var i = 0; i < array_length_1d(sheet_text); ++i) {
        index = irandom(array_length_1d(sf_text_string) - 1);
        ib_sheet_set_texture(sheet_text[i], surface_get_texture(sf_text_front[index]), surface_get_texture(sf_text_back[index]));
    }

    // Sets the textures for the button sheet.
    ib_sheet_set_texture(sheet_buttons, surface_get_texture(sf_buttons), sprite_get_texture(spr_example_blank_sheet_back, 0),
                              undefined, undefined, undefined, sprite_get_uvs(spr_example_blank_sheet_back, 0));
                              
    // Sets the textures for the text input field sheet.
    ib_sheet_set_texture(sheet_input_field, surface_get_texture(sf_input_field), sprite_get_texture(spr_example_blank_sheet_back, 0),
                              undefined, undefined, undefined, sprite_get_uvs(spr_example_blank_sheet_back, 0));
}
