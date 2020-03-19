window_set_fullscreen(true);

if (audio_is_playing(AtSunriseByProudMusicLibrary) == false)
	audio_play_sound(AtSunriseByProudMusicLibrary, 1, true);

objArrow.image_alpha = 0;
objArrow.alarm[0] = 5 * room_speed;