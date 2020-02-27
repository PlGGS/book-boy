/// @description  ib_book_get_left_sheet(book instance id)
/// @param book instance id
//
// Returns the instance id of the left sheet that is currently open. If the book is transitioning, the sheet the furthest to the left is returned.
// If there are no sheets to the left or if the book is in transition, the built in GameMaker value "noone" is returned.
//
// book instance id: The instance id of the book. Returned at book creation.

with (argument0) {
    if (transition_sheet_last >= transition_sheet_first || transition_sheet_last < 0) return noone;
    return list_sheets[| transition_sheet_last];
}
