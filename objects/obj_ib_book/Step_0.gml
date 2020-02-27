if (transition_speed_reduction) {
    transition_speed = (max(transition_sheet_last - transition_sheet_first - 1, 0) * sheet_spacing + 2) / (transition_time / 1000 * 60);
}

var instance, instance_next, instance_previous, i, t, target, factor_delta_timed_0 = 0.2 * (delta_time / (1000000 / 60)), factor_delta_timed_1 = 0.05 * (delta_time / (1000000 / 60)),
    sheets = ds_list_size(list_sheets), last = sheets - 1, transition_sheet_first_previous = transition_sheet_first, transition_sheet_last_previous = transition_sheet_last,
    transition_speed_delta_timed = transition_speed * (delta_time / (1000000 / 60));

for (i = transition_sheet_first; i <= transition_sheet_last; ++i) {
    instance = list_sheets[| i];
    if (i < transition_sheet_target) {
        // Changes timers for pages flipping to the left.
        instance_previous = list_sheets[| i - 1];
        if (instance.timer == 1) instance.flip_direction = -1; else instance.flip_direction += (-1 - instance.flip_direction) * factor_delta_timed_1;
        if (i == 0 || instance_previous.timer_previous == -1 || instance.timer - instance_previous.timer_previous > sheet_spacing) instance.timer = max(-1, instance.timer - transition_speed_delta_timed);
        if (instance.timer == -1) {
            instance.stiffness = instance.stiffness_default;
            ++transition_sheet_first;
        }
    } else {
        // Changes timers for pages flipping to the right.
        instance_next = list_sheets[| i + 1];
        if (instance.timer == -1) instance.flip_direction = 1; else instance.flip_direction += (1 - instance.flip_direction) * factor_delta_timed_1;
        if (i == sheets - 1 || instance_next.timer_previous == 1 || instance_next.timer_previous - instance.timer > sheet_spacing) instance.timer = min(1, instance.timer + transition_speed_delta_timed);
        if (instance.timer == 1) {
            instance.stiffness = instance.stiffness_default;
            --transition_sheet_last;
        }
    }
}

// To avoid sheets intersecting, this code changes the stiffness of a sheet if the sheet to the right or left has a higher stiffness and is close.
for (i = transition_sheet_first; i <= transition_sheet_last; ++i) {
    instance = list_sheets[| i];
    instance_previous = list_sheets[| i - 1];
    instance_next = list_sheets[| i + 1];
    target = instance.stiffness_default;
    if (abs(instance.timer) < 0.5) {
        if (instance.flip_direction < 0 && i != last && instance_next.stiffness > instance.stiffness_default && instance_next.timer < 1) {
            target = lerp(instance_next.stiffness, instance.stiffness_default, clamp(instance_next.timer - instance.timer, 0, 1));
        } else if (i != 0 && instance_previous.stiffness > instance.stiffness_default && instance_previous.timer > -1) {
            target = lerp(instance_previous.stiffness, instance.stiffness_default, clamp(instance.timer - instance_previous.timer, 0, 1));
        }
    }
    instance.stiffness += (target - instance.stiffness) * factor_delta_timed_0;
}

for (i = transition_sheet_first_previous; i <= transition_sheet_last_previous; ++i) list_sheets[| i].timer_previous = list_sheets[| i].timer;

sheet = transition_sheet_first;

