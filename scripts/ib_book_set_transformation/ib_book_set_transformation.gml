/// @description  ib_book_set_transformation(book instance id, x, y, x scale, y scale)
/// @param book instance id
/// @param  x
/// @param  y
/// @param  x scale
/// @param  y scale
//
// Changes the position and scale of the book. Note that this only scales and positions an underlying 
// surface, so scaling down will not be more performant. If you want to change the size of the actual 
// mesh that gets rendered, you will have to set the size for each book sheet with ib_sheet_set_texture 
// or when you add the sheet with ib_book_add_sheet.
//
// book instance id: The instance id of the book. Returned at book creation.
// x, y: The x- and y-coordinate of the book. The book will be centered at this position.
// x scale, y scale: The scale of the book. 1, 1 is the default where no scaling is applied.

with (argument[0]) {
    x = argument[1]; y = argument[2];
    scale_x = argument[3]; scale_y = argument[4];    
}
