// Lets the user navigate the book.
if (keyboard_check_pressed(vk_right)) {
    // Moves one sheet ahead in the book.
	ib_book_goto_sheet(book, 1, true);
}
else if (keyboard_check_pressed(vk_left)) {
    // Moves one sheet back in the book.
	ib_book_goto_sheet(book, -1, true);
}
else if (keyboard_check_pressed(vk_home)) {
    // Moves to cover
	ib_book_goto_sheet(book, 0);
}
else if (keyboard_check_pressed(vk_end)) {
    // Moves to back
	ib_book_goto_sheet(book, 100);
}

// Lets the user move the player
if (keyboard_check(ord("W"))) {
    // Moves the player forwards
	//sprPlayer.y -= playerSpeed;
	playerLocY -= playerSpeed;
}
else if (keyboard_check(ord("A"))) {
    // Moves the player left
	//sprPlayer.x += playerSpeed;
	playerLocX -= playerSpeed;
}
if (keyboard_check(ord("S"))) {
    // Moves the player right
	//sprPlayer.y += playerSpeed;
	playerLocY += playerSpeed;
}
else if (keyboard_check(ord("D"))) {
    // Moves the player backwards
	//sprPlayer.x -= playerSpeed;
	playerLocX += playerSpeed;
}
