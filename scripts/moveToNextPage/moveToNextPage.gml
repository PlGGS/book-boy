/// @description  moveToNextPage()
//
// Turns to the next page and moves the player accordingly
//

//below turns page
ib_book_goto_sheet(objBook.book, 1, true);

//below "hides" the teleportation of the player back to left page
//show_debug_message(room_speed * 0.53 - 0.5 * ((objBook.playerLocX - objBook.sheet_width) / objBook.sheet_width));
												//(1 thru 348) / 381
objBook.alarm[0] = room_speed * 0.53 - 0.5 * ((objBook.playerLocX - objBook.sheet_width) / objBook.sheet_width);
