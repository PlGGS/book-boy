/// @description Create main book and sheets

pageSurfaceList = ds_list_create();

cover_width = sprite_get_width(spr_example_book_cover);
cover_height = sprite_get_height(spr_example_book_cover);
sheet_width = sprite_get_width(spr_example_blank_sheet_front);
sheet_height = sprite_get_height(spr_example_blank_sheet_front);

// Creates a book.
book_x = room_width * 0.5;
book_y = room_height * 0.5 - 30;
book = ib_book_create(book_x, book_y, 41, 56);

// Adds the front cover sheet to the book.
ib_book_add_sheet(book, sprite_get_texture(spr_example_book_cover, 0), sprite_get_texture(spr_example_book_cover, 1), cover_width, cover_height,
                  sprite_get_uvs(spr_example_book_cover, 0), sprite_get_uvs(spr_example_book_cover, 1), undefined, 10, undefined, 1, true, 2, 12);

// Adds a sheet saying "Example book by Mytino".
ib_book_add_sheet(book, sprite_get_texture(spr_example_misc_sheet_front, 1), sprite_get_texture(spr_example_blank_sheet_back, 0), sheet_width, sheet_height,
                  sprite_get_uvs(spr_example_misc_sheet_front, 1), sprite_get_uvs(spr_example_blank_sheet_back, 0));

// Adds a sheet saying "Chapter 1: Jailbreak".
//ib_book_add_sheet(book, sprite_get_texture(spr_example_misc_sheet_front, 8), sprite_get_texture(spr_example_blank_sheet_back, 0), sheet_width, sheet_height,
//                  sprite_get_uvs(spr_example_misc_sheet_front, 8), sprite_get_uvs(spr_example_blank_sheet_back, 0));

//Chapter 1
//Add pages for chapter 1
for (var i = 0; i < 3; i++) {
	ch1surfs[i] = -1;
	ch1sheets[i] = ib_book_add_sheet(book, sprite_get_texture(spr_example_blank_sheet_front, 0), sprite_get_texture(spr_example_blank_sheet_back, 0), sheet_width, sheet_height,
                  sprite_get_uvs(spr_example_blank_sheet_front, 0), sprite_get_uvs(spr_example_blank_sheet_back, 0));
}

/*
chapter1Sheets = ds_list_create();

for (var i = 0; i < 2; i++) {
	ds_list_add(pageSurfaceList, -1);
	if (i > 0) {
		ds_list_add(chapter1Sheets, ib_book_add_sheet(book, pageSurfaceList[| (i - 1)], pageSurfaceList[| i]));
	}
}
*/


// Creates a variable for a surface to contain our button example. Then a sheet is added to the book and its id is stored in sheet_buttons. This is similar to the way we create a surface
// for the text sheets and store the sheet id there. After this, the button instances are created.
sf_buttons = -1;
sheet_buttons = ib_book_add_sheet(book, -1, -1);
(instance_create(50, 112, objBookButton)).button_id = 0;
(instance_create(50, 308, objBookButton)).button_id = 1;

// Creates a variable for a surface to contain our text input field example. Then a sheet is added to the book and its id is stored in sheet_input_field.
sf_input_field = -1;
sheet_input_field = ib_book_add_sheet(book, -1, -1);

// Adds a blank sheet.
/*
ib_book_add_sheet(book, sprite_get_texture(spr_example_blank_sheet_front, 0), sprite_get_texture(spr_example_blank_sheet_back, 0), sheet_width, sheet_height,
                  sprite_get_uvs(spr_example_blank_sheet_front, 0), sprite_get_uvs(spr_example_blank_sheet_back, 0));
*/

// Adds the back cover sheet to the book.
ib_book_add_sheet(book, sprite_get_texture(spr_example_book_cover, 2), sprite_get_texture(spr_example_book_cover, 3), cover_width, cover_height,
                  sprite_get_uvs(spr_example_book_cover, 2), sprite_get_uvs(spr_example_book_cover, 3), undefined, 10, undefined, 1, true, 2, 12);

// Enables inerpolation and vsync.
texture_set_interpolation(true);
display_reset(0, true);
