if (pressedRight == false) {
	if (image_alpha < 1) {
		image_alpha += 0.01;
		alarm[0] = 5;
	}
}
else {
	if (image_alpha > 0) {
		image_alpha -= 0.01;
		alarm[0] = 5;	
	}
	else {
		
	}
}