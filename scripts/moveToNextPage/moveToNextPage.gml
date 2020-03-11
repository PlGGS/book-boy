/// @description  moveToNextPage()
//
// Turns to the next page and moves the player accordingly
//

//below turns page
ib_book_goto_sheet(objBook.book, 1, true);

//below "hides" the teleportation of the player back to left page
objBook.alarm[0] = room_speed * 0.535;
