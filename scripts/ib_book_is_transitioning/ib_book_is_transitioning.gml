/// @description  ib_book_is_transitioning(book instance id)
/// @param book instance id
//
// Returns true if the any of the sheets of the book are flipping and false otherwise.
//
// book instance id: The instance id of the book. Returned at book creation.

with (argument0) {
    return (transition_sheet_last >= transition_sheet_first);
}
