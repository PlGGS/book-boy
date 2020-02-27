/// @description  ib_sheet_destroy(sheet instance id)
/// @param sheet instance id
//
// Destroys a sheet, removing it from the book it is part of.
//
// sheet instance id: The instance id of the sheet to delete. Returned by book_add_sheet.

var i, j, key_last, instance = argument[0], index, change, memory, t;

with (instance.book) {
    t = instance.matrix;
    if (t[0] >= max_sheet_width) {
        max_sheet_width = -1;
        for (i = ds_list_size(list_sheets) - 1; i >= 0; --i) {
            t = list_sheets[| i].matrix;
            max_sheet_width = max(max_sheet_width, t[0]);
        }
    }

    with (instance) instance_destroy();
    index = ds_list_find_index(list_sheets, instance);
    ds_list_delete(list_sheets, index);
    
    for (i = ds_list_size(list_sheets_with_special_visibility_type) - 1; i >= 0; --i) {
        if (index == list_sheets_with_special_visibility_type[| i]) ds_list_delete(list_sheets_with_special_visibility_type, i);
        else if (index < list_sheets_with_special_visibility_type[| i]) --list_sheets_with_special_visibility_type[| i];
    }
    
    ds_map_delete(map_sheet_alpha, index);
    i = ds_map_find_first(map_sheet_alpha); key_last = ds_map_find_last(map_sheet_alpha); j = 0;
    if (ds_map_size(map_sheet_alpha)) while (true) {
        if (index < i) {change[j] = i; memory[j++] = map_sheet_alpha[? i];}
        if (i == key_last) break;
        i = ds_map_find_next(map_sheet_alpha, i);
    }
    for (i = 0; i < j; ++i) ds_map_delete(map_sheet_alpha, change[i]);
    for (i = 0; i < j; ++i) map_sheet_alpha[? change[i] - 1] = memory[i];
}
