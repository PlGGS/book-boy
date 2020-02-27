/// @description  ib_sheet_get_index(sheet instance id)
/// @param sheet instance id
//
// Returns the index of the sheet instance, as in the index of where the sheet is in the book. If it's the first sheet of the book, 0 is returned. If it's the second sheet of the book, 1 is returned. Etc.
//
// sheet instance id: The instance id of the sheet. Returned by book_add_sheet.

return ds_list_find_index(argument0.book.list_sheets, argument0);
