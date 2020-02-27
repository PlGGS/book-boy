/// @description  ib_sheet_is_visible(sheet instance id)
/// @param sheet instance id
//
// Returns true if the specified sheet is being drawn. This can be useful if for example your sheet uses a texture from a surface, and you only want to update
// the surface if the sheet is visible (i.e. being drawn) to save on performance. This is done in the example provided together with this asset for the button
// and the text field sheets.
//
// sheet instance id: The instance id of the sheet. Returned by book_add_sheet.

var i, j, instance;

with (argument0.book) {
    var sheets = ds_list_size(list_sheets), sheet_last = sheets - 1;

    // Loops through still sheets to the left to check.
    for (i = transition_sheet_first - 1; i >= 0; --i) {
        instance = list_sheets[| i];
        if (instance == argument0) return true;
        if (!instance.transparent) break;
    }
    
    // Loops through still sheets to the right to check.
    for (i = transition_sheet_last + 1; i <= sheet_last; ++i) {
        instance = list_sheets[| i];
        if (instance == argument0) return true;
        if (!instance.transparent) break;
    }
    
    // Loops through moving sheets to check.
    for (i = transition_sheet_first; i <= transition_sheet_last; ++i) {
        instance = list_sheets[| i];
        if (instance == argument0) return true;
    }
    
    // Loops through special visibility type sheets to check.
    for (j = ds_list_size(list_sheets_with_special_visibility_type) - 1; j >= 0; --j) {
        i = list_sheets_with_special_visibility_type[| j];
        instance = list_sheets[| i];
        if (instance == argument0) {
            if (instance.visibility_type != 2 || ((i != 0 || sheet != sheets || list_sheets[| sheet_last].timer != -1) && (i != sheet_last || sheet != 0 || list_sheets[| 0].timer != 1))) {
                return true;
            }
        }
    }
    
    return false;
}
