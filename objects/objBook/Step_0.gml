//chapter 1
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
		// Keeps player in bounds
		if (playerLocX > ((sheet_width * 2) - (sprite_get_width(sprBookBoy) / 2))) {
			playerLocX = ((sheet_width * 2) - (sprite_get_width(sprBookBoy) / 2)) - 1;
		}
		else if (playerLocX < (ib_book_get_left_sheet(book).x + (sprite_get_width(sprBookBoy)) + 6)) {
			playerLocX = (ib_book_get_left_sheet(book).x + (sprite_get_width(sprBookBoy))) + 6;
		}
		else {
			if (ib_sheet_is_visible(sheetCh1PgTitle_1) && ib_sheet_is_visible(sheetCh1Pg2_3)) {
				//check if get key
				if (playerLocX > 430 && playerLocX < 450) {
					hasKey = true;
				}
				
				if (keyboard_check(ord("A"))) {
					if (playerLocX + (objBookBoy.sprite_width / 2) < 140 ||
						playerLocX > 140 && playerLocX - playerSpeed > 140) {
						// Moves the player left
						playerLocX -= playerSpeed;
					}
				}
				if (keyboard_check(ord("D"))) {
					if (playerLocX > 140 ||
						playerLocX + (objBookBoy.sprite_width / 2) < 133 && playerLocX + (objBookBoy.sprite_width / 2) + playerSpeed < 133) {
						// Moves the player backwards
						playerLocX += playerSpeed;
					}
				}
			}
			else {
				//check if get to exit with key
				if (playerLocX > 660 && playerLocX < 680) {
					if (hasKey) {
						completedCh[1] = true;
					}
				}
				
				if (keyboard_check(ord("A"))) {
					// Moves the player left
					playerLocX -= playerSpeed;
				}
				if (keyboard_check(ord("D"))) {
					// Moves the player backwards
					playerLocX += playerSpeed;
				}
			}
		}
		show_debug_message(string(playerLocX));
	}
}
//intro
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

playerLocPrevX = playerLocX;
playerLocPrevY = playerLocY;
