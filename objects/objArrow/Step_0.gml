show_debug_message(pressedRight);
if (pressedRight == false && keyboard_check_pressed(vk_right)) {
	pressedRight = true;
}
if (pressedRight == true && keyboard_check_pressed(vk_right)) {
	alarm[0] = 1;
}