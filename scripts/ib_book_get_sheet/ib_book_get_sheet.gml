/// @description  ib_book_get_sheet(book instance id, sheet index)
/// @param book instance id
/// @param  sheet index
//
// Returns the sheet instance at the specified index in the book. If index 0 is entered, the instance id for the first sheet of the book is returned.
// If index 1 is entered, the instance id for the second sheet of the book is returned. Etc.
//
// book instance id: The instance id of the book. Returned at book creation.
// sheet index: The sheet to go to. This is an index starting at 0 and ending at the number of sheets minus one.

return argument0.list_sheets[| argument1];
