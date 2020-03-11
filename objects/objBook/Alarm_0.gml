//"hides" teleportation of the player back to the previous page
if (playerLocX > sheet_width) {
	playerLocX = sheet_width - (playerLocX - sheet_width);
}