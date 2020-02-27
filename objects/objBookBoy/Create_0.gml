/// @description Place player on book

// Moves the button so it's placed relative to the book. This is just for collision checking with the mouse. The button's x and y are actually just used for collision checking.
// xstart and ystart is the position of the button relative to the book, so we use this to offset the button correctly.
x = objBook.book_x + xstart; y = objBook.book_y + ystart;