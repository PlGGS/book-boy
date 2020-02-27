// Lets the user navigate the book.
if (mouse_check_button_pressed(mb_left)) {
    // Moves one sheet ahead in the book.
    if (point_in_rectangle(mouse_x, mouse_y, room_width * 0.5 + 48, room_height - 82, room_width * 0.5 + 102, room_height - 30)) {
        ib_book_goto_sheet(book, 1, true);
    }
    
    // Moves one sheet back in the book.
    if (point_in_rectangle(mouse_x, mouse_y, room_width * 0.5 - 102, room_height - 82, room_width * 0.5 - 48, room_height - 30)) {
        ib_book_goto_sheet(book, -1, true);
    }
    
    // Moves five sheets ahead in the book.
    if (point_in_rectangle(mouse_x, mouse_y, room_width * 0.5 + 140, room_height - 82, room_width * 0.5 + 194, room_height - 30)) {
        ib_book_goto_sheet(book, 5, true);
    }
    
    // Moves five sheets back in the book.
    if (point_in_rectangle(mouse_x, mouse_y, room_width * 0.5 - 194, room_height - 82, room_width * 0.5 - 140, room_height - 30)) {
        ib_book_goto_sheet(book, -5, true);
    }
}

