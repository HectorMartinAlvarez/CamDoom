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

void updateActions() {
	slayer.isMoving = false;

	for (Character keyValue : actions.keySet()) {
		if ((Boolean)actions.get(keyValue)) {
			switch(keyValue) {
				case 'W': case 'w':
					game.slayer.moveSlayer();
					slayer.isMoving = true;
				break;

				case 'A': case 'a':
					game.slayer.rotateCamera(2);
					slayer.isMoving = true;
				break;

				case 'D': case 'd':
					game.slayer.rotateCamera(-2);
					slayer.isMoving = true;
				break;
			}
		}
	}
}

void checkMenu() {
	// Choose an option
	if (key == CODED) {
		switch (keyCode) {
			case DOWN: if (selectedOption < 2) { selectSound.play(); selectedOption++; } break;
			case UP: if (selectedOption > 0) { selectSound.play(); selectedOption--; } break;
		}
	}

	// Execute an option
	else {
		switch (key) {
			case ESC: key = 0; break;
			case ENTER:
				switch (selectedOption) {
					case 0:	// Start game
						confirmSound.play(); gameState = 0;
					break;

					case 1: // Settings
						confirmSound.play();
						gameState = 3;
					break;

					case 2:	// Exit
						exitSound.play();
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
			case DOWN: if (selectedOption < 2) { selectSound.play(); selectedOption++; } break;
			case UP: if (selectedOption > 0) { selectSound.play(); selectedOption--; } break;
		}
	}

	// Execute an option
	else {
		switch (key) {
			case ESC: key = 0; break;
			case ENTER:
				switch (selectedOption) {
					case 0:	// Increase music
						confirmSound.play();
						increaseVolumeForMusic();
					break;

					case 1: // Increase sound
						confirmSound.play();
						increaseVolumeForEffects();
					break;

					case 2:	// Go back
						confirmSound.play();
						gameState = 1; selectedOption = 0;
					break;
				}
			break;
		}
	}
}

void checkSlayerControls() {
	// Pause menu
	if (key != CODED && key == ESC) {
		key = 0; confirmSound.play();
		game.slayer.camera.setActive(false);
		gameState = 2; selectedOption = 0;
	}
}

void checkPause() {
	// Choose an option
	if (key == CODED) {
		switch (keyCode) {
			case DOWN: if (selectedOption < 2) { selectSound.play(); selectedOption++; } break;
			case UP: if (selectedOption > 0) { selectSound.play(); selectedOption--; } break;
		}
	}

	// Execute an option
	else {
		switch (key) {
			case ESC: key = 0; break;
			case ENTER:
				switch (selectedOption) {
					case 0:	// Start game
						confirmSound.play(); gameState = 0;
					break;

					case 1: // Settings
						confirmSound.play();
						gameState = 4;
					break;

					case 2:	// Go back
						confirmSound.play();
						game.reset();
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
			case DOWN: if (selectedOption < 2) { selectSound.play(); selectedOption++; } break;
			case UP: if (selectedOption > 0) { selectSound.play(); selectedOption--; } break;
		}
	}

	// Execute an option
	else {
		switch (key) {
			case ESC: key = 0; break;
			case ENTER:
				switch (selectedOption) {
					case 0:	// Increase music
						confirmSound.play();
						increaseVolumeForMusic();
					break;

					case 1: // Increase sound
						confirmSound.play();
						increaseVolumeForEffects();
					break;

					case 2:	// Go back
						confirmSound.play();
						gameState = 2; selectedOption = 0;
					break;
				}
			break;
		}
	}
}

void checkDeath() {
	// Choose an option
	if (key == CODED) {
		switch (keyCode) {
			case DOWN: if (selectedOption < 2) { selectSound.play(); selectedOption++; } break;
			case UP: if (selectedOption > 0) { selectSound.play(); selectedOption--; } break;
		}
	}

	// Execute an option
	else {
		switch (key) {
			case ESC: key = 0; break;
			case ENTER:
				switch (selectedOption) {
					case 0:	// Start game
						confirmSound.play(); gameState = 0;
					break;

					case 1:	// Go back
						confirmSound.play();
						gameState = 1; selectedOption = 0;
					break;
				}
			break;
		}
	}
}

void keyTyped() {
	if (actions.keySet().contains(key))
		actions.put(key, true);

	switch(gameState) {
		case 0: checkSlayerControls(); 		break;
		case 1: checkMenu(); 			 			  break;
		case 2: checkPause(); 		 			  break;
		case 3: checkSettingsFromMenu();  break;
		case 4: checkSettingsFromPause(); break;
		case 5: checkDeath(); 						break;
	}
}

void keyPressed() {
	if (actions.keySet().contains(key))
		actions.put(key, true);

	switch(gameState) {
		case 0: checkSlayerControls(); 		break;
		case 1: checkMenu(); 			 			  break;
		case 2: checkPause(); 		 			  break;
		case 3: checkSettingsFromMenu();  break;
		case 4: checkSettingsFromPause(); break;
		case 5: checkDeath(); 						break;
	}
}

void keyReleased() {
	if (actions.keySet().contains(key))
		actions.put(key, false);
}

void mousePressed() {
	if (gameState == 0) {
		if (game.slayer.health > 0) {
			// Shoot action
			if (mouseButton == LEFT) {
				game.slayer.status = CDoomSlayerStatus.SLAYER_ATTACK;
			}

			// Just for testing (temporal)
			if (mouseButton == RIGHT) {
				slayer.doDamage();
			}
		}
	}
}
