/// @description  moveToNextPage()
//
// Turns to the next page and moves the player accordingly
//

//below turns page
ib_book_goto_sheet(objBook.book, -1, true);

//below fades the player out, so their appearance on the previous page is less jarring
repeat (20)
	objBook.alarm[1] = 0;
