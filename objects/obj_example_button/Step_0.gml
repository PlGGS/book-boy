// Sets the correct image of the sprite dependent on whether it's the top or bottom button on the sheet.
image_index = button_id * 2;

// Moves the button so it's placed relative to the book. This is just for collision checking with the mouse. The button's x and y are actually just used for collision checking.
// xstart and ystart is the position of the button relative to the book, so we use this to offset the button correctly.
x = obj_example_main.book_x + xstart; y = obj_example_main.book_y + ystart;

// If the book is at the correct page (as in the current right sheet of the book is the button sheet), and the book is not being flipped, then check for mouse interaction.
if (ib_book_get_right_sheet(obj_example_main.book) == obj_example_main.sheet_buttons && !ib_book_is_transitioning(obj_example_main.book)) {
    
    // Transforms the mouse position from the curved version of the sheet to the flat version. This is done because the button's collision mask doesn't get curved out like
    // the button graphics do, so we have to convert back to the flat version before doing collision checking.
    var mouse_transformed = ib_sheet_position_curved_to_flat(obj_example_main.sheet_buttons, mouse_x, mouse_y, room_width, room_height);
    
    // If the mouse is within the button, highlight the button and move to another area in the book if the left mouse button is pressed.
    if (position_meeting(mouse_transformed[0], mouse_transformed[1], id)) {
        image_index = button_id * 2 + 1;
        if (mouse_check_button_pressed(mb_left)) {
            switch (button_id) {
                case 0: ib_book_goto_sheet(obj_example_main.book, 0); break;
                case 1: ib_book_goto_sheet(obj_example_main.book, 16); break;
            }
        }
    }
}

