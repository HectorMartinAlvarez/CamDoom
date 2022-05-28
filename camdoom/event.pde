// This file is part of CamDoom - https://github.com/HectorMartinAlvarez/CamDoom
//
// CamDoom is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// CamDoom is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with CamDoom. If not, see <http://www.gnu.org/licenses/>.

void checkMenu() {
	// Choose an option
	if (key == CODED) {
		switch (keyCode) {
			case DOWN: if (selectedOption < 2) { select.play(); selectedOption++; } break;
			case UP: if (selectedOption > 0) { select.play(); selectedOption--; } break;
		}
	}

	// Execute an option
	else {
		switch (key) {
			case ESC: key = 0; break;
			case ENTER:
				switch (selectedOption) {
					case 0:	// Start game
						confirm.play(); gameState = 0;
						game.slayer.cam.controllable = true;
					break;

					case 1: // Settings
						confirm.play();
						gameState = 3;
					break;

					case 2:	// Exit
						exit.play();
						delay(1500);
						exit();
					break;
				}
			break;
		}
	}
}

void checkSettingsFromMenu() {
	// Choose an option
	if (key == CODED) {
		switch (keyCode) {
			case DOWN: if (selectedOption < 2) { select.play(); selectedOption++; } break;
			case UP: if (selectedOption > 0) { select.play(); selectedOption--; } break;
		}
	}

	// Execute an option
	else {
		switch (key) {
			case ESC: key = 0; break;
			case ENTER:
				switch (selectedOption) {
					case 0:	// Increase music
						confirm.play();
						volumeMusic = volumeMusic < 1? volumeMusic + 0.2 : 0;
						if (volumeMusic > 1) volumeMusic = 1;
						adjustVolumeMusic();
					break;

					case 1: // Increase sound
						confirm.play();
						volumeSounds = volumeSounds < 1? volumeSounds + 0.2 : 0;
						if (volumeSounds > 1) volumeSounds = 1;
						adjustVolumeSounds();
					break;

					case 2:	// Go back
						confirm.play();
						game.slayer.cam.controllable = false;
						gameState = 1; selectedOption = 0;
					break;
				}
			break;
		}
	}
}

void checkStartPause() {
	if (key != CODED && key == ESC) {
		key = 0; confirm.play();
		game.slayer.cam.controllable = false;
		gameState = 2; selectedOption = 0;
	}
}

void checkPause() {
	// Choose an option
	if (key == CODED) {
		switch (keyCode) {
			case DOWN: if (selectedOption < 2) { select.play(); selectedOption++; } break;
			case UP: if (selectedOption > 0) { select.play(); selectedOption--; } break;
		}
	}

	// Execute an option
	else {
		switch (key) {
			case ESC: key = 0; break;
			case ENTER:
				switch (selectedOption) {
					case 0:	// Start game
						confirm.play(); gameState = 0;
						game.slayer.cam.controllable = true;
					break;

					case 1: // Settings
						confirm.play();
						gameState = 4;
					break;

					case 2:	// Go back
						confirm.play();
						game.slayer.cam.controllable = false;
						gameState = 1; selectedOption = 0;
					break;
				}
			break;
		}
	}
}

void checkSettingsFromPause() {
	// Choose an option
	if (key == CODED) {
		switch (keyCode) {
			case DOWN: if (selectedOption < 2) { select.play(); selectedOption++; } break;
			case UP: if (selectedOption > 0) { select.play(); selectedOption--; } break;
		}
	}

	// Execute an option
	else {
		switch (key) {
			case ESC: key = 0; break;
			case ENTER:
				switch (selectedOption) {
					case 0:	// Increase music
						confirm.play();
						volumeMusic = volumeMusic < 1? volumeMusic + 0.2 : 0;
						if (volumeMusic > 1) volumeMusic = 1;
						adjustVolumeMusic();
					break;

					case 1: // Increase sound
						confirm.play();
						volumeSounds = volumeSounds < 1? volumeSounds + 0.2 : 0;
						if (volumeSounds > 1) volumeSounds = 1;
						adjustVolumeSounds();
					break;

					case 2:	// Go back
						confirm.play();
						game.slayer.cam.controllable = false;
						gameState = 2; selectedOption = 0;
					break;
				}
			break;
		}
	}
}

void keyPressed() {
	// Main menu
	switch(gameState) {
		case 0: checkStartPause(); 			  break;
		case 1: checkMenu(); 			 			  break;
		case 2: checkPause(); 		 			  break;
		case 3: checkSettingsFromMenu();  break;
		case 4: checkSettingsFromPause(); break;
	}
}
