if ((ib_sheet_is_visible(sheetCh1PgTitle_1) && ib_sheet_is_visible(sheetCh1Pg2_3)) ||
	 (ib_sheet_is_visible(sheetCh1Pg2_3) && ib_sheet_is_visible(sheetCh1Pg4_End))) {
	//chapter 1 navigation
	if (keyboard_check_pressed(vk_right)) {
		if (ib_sheet_is_visible(sheetCh1Pg2_3) && ib_sheet_is_visible(sheetCh1Pg4_End)) {
			if (completedCh[1]) {
				//only progress if we've completed chapter 1
				moveToNextPage();
			}
		}
		else {
			moveToNextPage();
		}
	}
	else if (keyboard_check_pressed(vk_left)) {
	    // Moves one sheet back in the book.
		moveToPrevPage();
	}
		 
	//chapter 1 movement
	if (!ib_book_is_transitioning(book)) {
		// Lets the user move the player
		if (keyboard_check(ord("A"))) {
		    // Moves the player left
			//sprPlayer.x += playerSpeed;
			playerLocX -= playerSpeed;
		}
		if (keyboard_check(ord("D"))) {
		    // Moves the player backwards
			//sprPlayer.x -= playerSpeed;
			playerLocX += playerSpeed;
		}
	}
}
else {
	//intro navigation
	if (keyboard_check_pressed(vk_right)) {
		moveToNextPage();
	}
	else if (keyboard_check_pressed(vk_left)) {
	    // Moves one sheet back in the book.
		moveToPrevPage();
	}
}