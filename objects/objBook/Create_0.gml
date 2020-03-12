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

for (var i = 1; i < 2; i++) {
	completedCh[i] = false;
}
hasKey = false;

// Adds the front cover sheet to the book.
sheetCover = ib_book_add_sheet(book, sprite_get_texture(spr_example_book_cover, 0), sprite_get_texture(spr_example_book_cover, 1), cover_width, cover_height,
                  sprite_get_uvs(spr_example_book_cover, 0), sprite_get_uvs(spr_example_book_cover, 1), undefined, 10, undefined, 1, true, 2, 12);

// Adds the intro sheet
sheetIntro = ib_book_add_sheet(book, sprite_get_texture(spr_example_misc_sheet_front, 1), sprite_get_texture(spr_example_blank_sheet_back, 0), sheet_width, sheet_height,
                  sprite_get_uvs(spr_example_misc_sheet_front, 1), sprite_get_uvs(spr_example_blank_sheet_back, 0));

//Chapter 1
//Add both surfaces and sheets for chapter 1
surfCh1PgTitle = -1;
surfCh1Pg1 = -1;
surfCh1Pg2 = -1;
surfCh1Pg3 = -1;
surfCh1Pg4 = -1;
surfCh1PgEnd = -1;
// Adds a sheet saying "Chapter 1: Jailbreak"
sheetCh1PgTitle_1 = ib_book_add_sheet(book, sprite_get_texture(spr_misc_sheet_front, 0), sprite_get_texture(spr_misc_sheet_back, 0), sheet_width, sheet_height,
                  sprite_get_uvs(spr_misc_sheet_front, 0), sprite_get_uvs(spr_misc_sheet_back, 0));

sheetCh1Pg2_3 = ib_book_add_sheet(book, sprite_get_texture(spr_example_blank_sheet_front, 0), sprite_get_texture(spr_misc_sheet_back, 1), sheet_width, sheet_height,
                  sprite_get_uvs(spr_example_blank_sheet_front, 0), sprite_get_uvs(spr_misc_sheet_back, 1));
				  
sheetCh1Pg4_End = ib_book_add_sheet(book, sprite_get_texture(spr_example_blank_sheet_front, 0), sprite_get_texture(spr_misc_sheet_back, 2), sheet_width, sheet_height,
                  sprite_get_uvs(spr_example_blank_sheet_front, 0), sprite_get_uvs(spr_misc_sheet_back, 2));
//create objects
instance_create(50, 112, objBookBoy);
instance_create(50, 112, objBookBlock);
instance_create(50, 112, objWindow);
instance_create(50, 112, objKey);
instance_create(50, 112, objDoor);

//Chapter 2
//Add both surfaces and sheets for chapter 2
surfCh2PgTitle = -1;
surfCh2Pg1 = -1;
// Adds a sheet saying "Chapter 2: Coming Soon (Maybe)"
sheetCh2PgTitle_1 = ib_book_add_sheet(book, sprite_get_texture(spr_misc_sheet_front, 0), sprite_get_texture(spr_misc_sheet_back, 0), sheet_width, sheet_height,
                  sprite_get_uvs(spr_misc_sheet_front, 0), sprite_get_uvs(spr_misc_sheet_back, 0));

// Adds the back cover sheet to the book
ib_book_add_sheet(book, sprite_get_texture(spr_example_book_cover, 2), sprite_get_texture(spr_example_book_cover, 3), cover_width, cover_height,
                  sprite_get_uvs(spr_example_book_cover, 2), sprite_get_uvs(spr_example_book_cover, 3), undefined, 10, undefined, 1, true, 2, 12);

// Enables inerpolation and vsync
texture_set_interpolation(true);
display_reset(0, true);
