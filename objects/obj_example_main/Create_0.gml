var cover_width = sprite_get_width(spr_example_book_cover), cover_height = sprite_get_height(spr_example_book_cover),
    sheet_width = sprite_get_width(spr_example_blank_sheet_front), sheet_height = sprite_get_height(spr_example_blank_sheet_front);

// Creates a book.
book_x = room_width * 0.5; book_y = room_height * 0.5 - 30;
book = ib_book_create(book_x, book_y, 41, 56);

// Adds the front cover sheet to the book.
ib_book_add_sheet(book, sprite_get_texture(spr_example_book_cover, 0), sprite_get_texture(spr_example_book_cover, 1), cover_width, cover_height,
                  sprite_get_uvs(spr_example_book_cover, 0), sprite_get_uvs(spr_example_book_cover, 1), undefined, 10, undefined, 1, true, 2, 12);

// Adds a sheet saying "Example book by Mytino".
ib_book_add_sheet(book, sprite_get_texture(spr_example_misc_sheet_front, 1), sprite_get_texture(spr_example_blank_sheet_back, 0), sheet_width, sheet_height,
                  sprite_get_uvs(spr_example_misc_sheet_front, 1), sprite_get_uvs(spr_example_blank_sheet_back, 0));
                                    
// Creates an array to contain some random text that we will add to our book's pages.
sf_text_string[0] = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In quam leo, convallis in mauris eu, interdum consectetur nisl. Morbi nec eros est. Nam nisl nisl, mollis quis blandit quis, sagittis sit amet mi. Sed a dignissim felis, a auctor enim. Morbi at efficitur arcu, at faucibus nibh. Pellentesque ut bibendum ipsum, in tristique purus. Integer id urna et erat sodales efficitur. Pellentesque dictum placerat ligula id egestas. Fusce a nisl at nunc aliquet bibendum. Proin semper felis at convallis ultricies. Aliquam erat volutpat.##Morbi eu pellentesque enim. Cras lobortis magna at nulla tincidunt malesuada. Suspendisse feugiat sapien in mi venenatis, quis posuere risus posuere. Suspendisse nisl nisl, luctus at nisi id, aliquet ornare tellus. Vestibulum tempor dui eleifend sollicitudin lobortis. Donec sodales laoreet metus vitae vulputate. Praesent metus nisi, iaculis id sodales id, mollis nec justo. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus id consequat eros. Nunc ullamcorper pulvinar est sed accumsan. Sed neque metus, placerat a fermentum.";
sf_text_string[1] = "Sed elementum ac turpis id congue. Phasellus elit enim, lobortis at arcu aliquet, tristique rhoncus sapien. Suspendisse condimentum, metus quis convallis gravida, tortor tortor convallis mauris, id tristique purus nunc in elit. Etiam vitae tortor vitae leo facilisis eleifend. Phasellus rutrum tincidunt sem, ut luctus purus eleifend vitae. Duis ac aliquet magna. Cras quam purus, aliquam vitae nibh at, dapibus lobortis mi. Etiam pellentesque, purus ut ultricies pretium, lorem lectus malesuada odio, at malesuada nisi dolor id augue. Aenean placerat, augue nec lobortis pharetra, ligula augue bibendum urna, at finibus velit magna at ligula. Aliquam finibus sollicitudin pharetra. Quisque congue, purus ac accumsan semper, urna massa porttitor nibh, a tincidunt nunc felis a nibh. Vestibulum vitae augue enim. Vestibulum tellus orci, malesuada ac sapien sit amet, bibendum sollicitudin eros. Morbi varius lacus id scelerisque posuere. Integer justo erat, porttitor sit amet massa ut, ornare efficitur erat. Suspendisse facilisis felis dui, sit amet posuere neque feugiat vitae. Donec consectetur arcu finibus vestibulum.";
sf_text_string[2] = "Morbi volutpat lorem vitae pretium tempus. Vestibulum eget consequat velit. Morbi sit amet est sem. Morbi semper venenatis lectus eget eleifend. Pellentesque aliquam nisi sed mi placerat, eu suscipit ex mattis. Aenean a malesuada lacus. Ut egestas at ipsum a laoreet. Nulla neque dui, tristique at urna eu, interdum dapibus libero. Mauris mi justo, facilisis et egestas ac, semper convallis lectus. Nulla sagittis vulputate dui at iaculis. Pellentesque ac lectus imperdiet, commodo nisi sed, scelerisque purus. Mauris ac condimentum turpis. Nunc ullamcorper dignissim ex, et pellentesque arcu suscipit eget. Suspendisse euismod, ex eu tempor pretium, nunc ligula laoreet orci, iaculis pulvinar leo neque in risus. Sed ullamcorper neque sed erat sodales scelerisque. Duis dignissim urna non libero faucibus, non sodales dolor sollicitudin. Lorem ipsum dolor sit amet, consectetur adipiscing elit.##In quam leo, convallis in mauris eu, interdum consectetur nisl. Morbi nec eros est. Nam nisl nisl, mollis quis blandit quis, sagittis sit amet mi. Sed a dignissim felis, a auctor enim.";
sf_text_string[3] = "Morbi volutpat lorem vitae pretium tempus. Vestibulum eget consequat velit. Morbi sit amet est sem. Morbi semper venenatis lectus eget eleifend.##Pellentesque aliquam nisi sed mi placerat, eu suscipit ex mattis. Aenean a malesuada lacus. Ut egestas at ipsum a laoreet. Nulla neque dui, tristique at urna eu, interdum dapibus libero. Mauris mi justo, facilisis et egestas ac, semper convallis lectus. Nulla sagittis vulputate dui at iaculis. Pellentesque ac lectus imperdiet, commodo nisi sed, scelerisque purus. Mauris ac condimentum turpis. Nunc ullamcorper dignissim ex, et pellentesque arcu suscipit eget. Suspendisse euismod, ex eu tempor pretium, nunc ligula laoreet orci, iaculis pulvinar leo neque in risus. Sed ullamcorper neque sed erat sodales scelerisque.##Duis dignissim urna non libero faucibus, non sodales dolor sollicitudin. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In quam leo, convallis in mauris eu, interdum consectetur nisl. Morbi nec eros est.";
                  
// Creates variables for eight surfaces made to contain text from the four strings above. Two surfaces per string, one that will contain the front part of a sheet with text, and another
// that will contain the back part of a sheet with text. Then 10 sheets are added to the book and their sheet ids are stored in the array called sheet_text, these sheets will use the 8
// surfaces as textures. Quote from the GameMaker manual: "NOTE: When working with surfaces there is the possibility that they can cease to exist at any time due to them being stored in
// texture memory. You should ALWAYS check that a surface exists using surface_exists before referencing them directly. For further information see Surfaces."
// Because of surfaces' possibility to cease existing, it makes it slightly more difficult to use surfaces as textures as we have to recreate the surfaces whenever they disappear.
// This also means that we have to reassign the texture to a sheet if a surface it is dependent on disappears. This is why we store the sheet ids in an array below, so that we can
// easily look them back up if the surfaces disappear, and assign them their new surface textures. We set the textures to -1 (meaning no texture), the textures will be set after
// the surfaces are created and drawn to in the draw event.
for (var i = 0; i < array_length_1d(sf_text_string); ++i) {
    sf_text_front[i] = -1;
    sf_text_back[i] = -1;
}
for (var i = 0; i < 10; ++i) {
    sheet_text[i] = ib_book_add_sheet(book, -1, -1);
}

// Adds a sheet saying "Interactive sheet elements".
ib_book_add_sheet(book, sprite_get_texture(spr_example_misc_sheet_front, 8), sprite_get_texture(spr_example_blank_sheet_back, 0), sheet_width, sheet_height,
                  sprite_get_uvs(spr_example_misc_sheet_front, 8), sprite_get_uvs(spr_example_blank_sheet_back, 0));

// Creates a variable for a surface to contain our button example. Then a sheet is added to the book and its id is stored in sheet_buttons. This is similar to the way we create a surface
// for the text sheets and store the sheet id there. After this, the button instances are created.
sf_buttons = -1;
sheet_buttons = ib_book_add_sheet(book, -1, -1);
(instance_create(50, 112, obj_example_button)).button_id = 0;
(instance_create(50, 308, obj_example_button)).button_id = 1;

// Creates a variable for a surface to contain our text input field example. Then a sheet is added to the book and its id is stored in sheet_input_field.
sf_input_field = -1;
sheet_input_field = ib_book_add_sheet(book, -1, -1);

// Adds a sheet concluding the interactive sheet elements section of the book.
ib_book_add_sheet(book, sprite_get_texture(spr_example_misc_sheet_front, 9), sprite_get_texture(spr_example_blank_sheet_back, 0), sheet_width, sheet_height,
                  sprite_get_uvs(spr_example_misc_sheet_front, 9), sprite_get_uvs(spr_example_blank_sheet_back, 0));

// Adds a sheet saying "Transparent sheets".
ib_book_add_sheet(book, sprite_get_texture(spr_example_misc_sheet_front, 0), sprite_get_texture(spr_example_blank_sheet_back, 0), sheet_width, sheet_height,
                  sprite_get_uvs(spr_example_misc_sheet_front, 0), sprite_get_uvs(spr_example_blank_sheet_back, 0));

// Adds three blue transparent sheets.
repeat (3) {
    ib_book_add_sheet(book, sprite_get_texture(spr_example_transparent_sheet_front, 0), sprite_get_texture(spr_example_transparent_sheet_back, 0), sheet_width, sheet_height,
                      sprite_get_uvs(spr_example_transparent_sheet_front, 0), sprite_get_uvs(spr_example_transparent_sheet_back, 0), undefined, undefined, undefined, undefined, true);
}

// Adds a blank sheet.
ib_book_add_sheet(book, sprite_get_texture(spr_example_blank_sheet_front, 0), sprite_get_texture(spr_example_blank_sheet_back, 0), sheet_width, sheet_height,
                  sprite_get_uvs(spr_example_blank_sheet_front, 0), sprite_get_uvs(spr_example_blank_sheet_back, 0));

// Adds five colored transparent sheets.
for (var i = 0; i < 5; ++i) {
    ib_book_add_sheet(book, sprite_get_texture(spr_example_transparent_sheet_front, i), sprite_get_texture(spr_example_transparent_sheet_back, i), sheet_width, sheet_height,
                      sprite_get_uvs(spr_example_transparent_sheet_front, i), sprite_get_uvs(spr_example_transparent_sheet_back, i), undefined, undefined, undefined, undefined, true);
}

// Adds a sheet saying "Sheets of various stiffness".
ib_book_add_sheet(book, sprite_get_texture(spr_example_misc_sheet_front, 2), sprite_get_texture(spr_example_blank_sheet_back, 0), sheet_width, sheet_height,
                  sprite_get_uvs(spr_example_misc_sheet_front, 2), sprite_get_uvs(spr_example_blank_sheet_back, 0));

// Adds 4 groups with 4 sheets each. Each group has an increasing stiffness.
for (var i = 0; i < 4; ++i) {
    repeat (4) {
        ib_book_add_sheet(book, sprite_get_texture(spr_example_misc_sheet_front, 3 + i), sprite_get_texture(spr_example_misc_sheet_back, i), sheet_width, sheet_height,
                          sprite_get_uvs(spr_example_misc_sheet_front, 3 + i), sprite_get_uvs(spr_example_misc_sheet_back, i), undefined, undefined, undefined, lerp(0.5, 1, i / 3));
    }
}
                                    
// Adds a blank sheet.
ib_book_add_sheet(book, sprite_get_texture(spr_example_blank_sheet_front, 0), sprite_get_texture(spr_example_blank_sheet_back, 0), sheet_width, sheet_height,
                  sprite_get_uvs(spr_example_blank_sheet_front, 0), sprite_get_uvs(spr_example_blank_sheet_back, 0));

// Adds a sheet with the last words of the book.
ib_book_add_sheet(book, sprite_get_texture(spr_example_misc_sheet_front, 11), sprite_get_texture(spr_example_blank_sheet_back, 0), sheet_width, sheet_height,
                  sprite_get_uvs(spr_example_misc_sheet_front, 11), sprite_get_uvs(spr_example_blank_sheet_back, 0));
                  
// Adds a blank sheet.
ib_book_add_sheet(book, sprite_get_texture(spr_example_blank_sheet_front, 0), sprite_get_texture(spr_example_blank_sheet_back, 0), sheet_width, sheet_height,
                  sprite_get_uvs(spr_example_blank_sheet_front, 0), sprite_get_uvs(spr_example_blank_sheet_back, 0));
                  
// Adds the back cover sheet to the book.
ib_book_add_sheet(book, sprite_get_texture(spr_example_book_cover, 2), sprite_get_texture(spr_example_book_cover, 3), cover_width, cover_height,
                  sprite_get_uvs(spr_example_book_cover, 2), sprite_get_uvs(spr_example_book_cover, 3), undefined, 10, undefined, 1, true, 2, 12);

// Enables inerpolation and vsync.
texture_set_interpolation(true);
display_reset(0, true);

