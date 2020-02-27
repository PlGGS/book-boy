/// @description  ib_book_get_right_sheet(book instance id)
/// @param book instance id
//
// Returns the instance id of the right sheet that is currently open. If the book is transitioning, the sheet the furthest to the right is returned.
// If there are no sheets to the right or if the book is in transition, the built in GameMaker value "noone" is returned.
//
// book instance id: The instance id of the book. Returned at book creation.

with (argument0) {
    if (transition_sheet_last >= transition_sheet_first || transition_sheet_first >= ds_list_size(list_sheets)) return noone;
    return list_sheets[| transition_sheet_first];
}
