// Sets the correct image of the sprite dependent on whether it's the top or bottom button on the sheet.
image_index = 0;

// If the book is at the correct page (as in the current right sheet of the book is the button sheet), and the book is not being flipped, then check for mouse interaction.
/*
if ((ib_book_get_left_sheet(objBook.book) == objBook.ch1sheets[0] || ib_book_get_right_sheet(objBook.book) == objBook.ch1sheets[0]) && !ib_book_is_transitioning(objBook.book)) {
    
    // Transforms the mouse position from the curved version of the sheet to the flat version. This is done because the button's collision mask doesn't get curved out like
    // the button graphics do, so we have to convert back to the flat version before doing collision checking.
    var mouse_transformed = ib_sheet_position_curved_to_flat(objBook.sheet_buttons, mouse_x, mouse_y, room_width, room_height);
    
    // If the mouse is within the button, highlight the button and move to another area in the book if the left mouse button is pressed.
    if (position_meeting(mouse_transformed[0], mouse_transformed[1], id)) {
        if (mouse_check_button_pressed(mb_left)) {
            sprite_index = sprBadBookBoy;
        }
    }
}
*/
