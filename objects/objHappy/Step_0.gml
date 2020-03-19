if (ib_sheet_is_visible(objBook.sheetCh1Pg4_End) == false && ib_sheet_is_visible(objBook.sheetCh2PgTitle_1) == true) {
	finishedBook = true;
}

if (finishedBook) {
	if (keyboard_check(ord("A"))) {
		x -= objBook.playerSpeed;
	}
	if (keyboard_check(ord("D"))) {
		x += objBook.playerSpeed;
	}
	if (keyboard_check(ord("W"))) {
		y -= objBook.playerSpeed;
	}
	if (keyboard_check(ord("S"))) {
		y += objBook.playerSpeed;
	}
}
