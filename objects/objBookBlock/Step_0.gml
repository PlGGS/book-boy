// Sets the correct image of the sprite dependent on whether it's the top or bottom button on the sheet.
image_index = 0;

//show_debug_message("bookboy: " + string(objBook.book_x + objBookBoy.xstart + objBook.playerLocX) + ", " + string(objBook.book_y + objBookBoy.ystart + objBook.playerLocY) + " | bookblock: " + string(x) + ", " + string(y));

if (position_meeting(objBook.book_y + objBookBoy.ystart + objBook.playerLocX, objBook.book_x + objBookBoy.ystart + objBook.playerLocY, id)) {
	objBook.playerLocY = objBook.playerLocPrevY;
}


