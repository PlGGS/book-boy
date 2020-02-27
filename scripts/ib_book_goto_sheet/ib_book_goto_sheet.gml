/// @description  ib_book_goto_sheet(book instance id, sheet index, [relative], [time], [sheet spacing], [speed reduction])
/// @param book instance id
/// @param  sheet index
/// @param  [relative]
/// @param  [time]
/// @param  [sheet spacing]
/// @param  [speed reduction]
//
// With this script you can indicate a sheet in the book to flip to.
//
// book instance id: The instance id of the book. Returned at book creation.
// sheet index: The sheet to go to. This is an index starting at 0 and ending at the number of sheets minus one.
// [relative]: If this is true, sheet index will be added to the current sheet. So if sheet index is e.g. -1, it will move one sheet to the left. If you omit this parameter or set it to undefined, false is chosen.
// [time]: The time in milliseconds for the transition to last. 0 will take you there instantly. If you omit this parameter or set it to undefined, 1000 (1 second) will be chosen.
// [sheet spacing]: The distance between multiple sheets in the transition in degrees. If you omit this parameter or set it to undefined, a default value of 20 degrees is chosen.
// [speed reduction]: If you flip e.g. 100 pages forward the speed of the flipping might be huge. You might want the speed to reduce when it gets close to the target sheet in which case you can set this parameter
//     to true. Otherwise set it to false. Note that if you have speed reduction enabled, the time parameter might not be exact. If you omit this parameter or set it to undefined, a default of true is used.

var i, size = ds_list_size(argument[0].list_sheets);

with (argument[0]) {
    if (argument_count > 2 && argument[2] == true) transition_sheet_target += argument[1]; else transition_sheet_target = argument[1];
    transition_sheet_target = clamp(transition_sheet_target, 0, size);
    if (argument_count > 3 && !is_undefined(argument[3])) transition_time = argument[3]; else transition_time = 1000;
    if (argument_count > 4 && !is_undefined(argument[4])) sheet_spacing = argument[4] / 180 * 2; else sheet_spacing = 20 / 180 * 2;
    if (argument_count > 5 && !is_undefined(argument[5])) transition_speed_reduction = argument[5]; else transition_speed_reduction = true;
    if (transition_time <= 0) {
        sheet = transition_sheet_target;
        transition_sheet_first = sheet;
        transition_sheet_last = sheet - 1;
        for (i = size - 1; i >= 0; --i) {
            if (i < sheet) list_sheets[| i].timer = -1; else list_sheets[| i].timer = 1;
            list_sheets[| i].timer_previous = list_sheets[| i].timer;   
        }
        transition_time = 0.0000001;
    } else {
        transition_sheet_first = min(transition_sheet_first, transition_sheet_target, sheet, size - 1);
        transition_sheet_last = min(max(transition_sheet_last, transition_sheet_target, sheet), size - 1);
        transition_speed = (max(transition_sheet_last - transition_sheet_first - 1, 0) * sheet_spacing + 2) / (transition_time / 1000 * 60);
    }
}
