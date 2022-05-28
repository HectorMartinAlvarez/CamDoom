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

void keyPressed() {
	if (gameState == 1 || gameState == 2) {
		if (key == CODED) {
			switch (keyCode) {
				case DOWN: if (selectedOption < 2) selectedOption++; break;
				case UP: if (selectedOption > 0) selectedOption--; break;
			}
		} else if (key == ENTER) {
			switch (selectedOption) {
				case 0: gameState = 0; game.slayer.cam.controllable = true; break;
				case 1: break;
				case 2:
					if (gameState == 1) exit();
					else {
						game.slayer.cam.controllable = false;
						gameState = 1; selectedOption = 0;
					}
				break;
			}
		}
	} else if (gameState == 0) {
		if (key != CODED) {
			if (key == ESC) {
				game.slayer.cam.controllable = false;
				key = 0; gameState = 2; selectedOption = 0;
			}
		}
	}
}
