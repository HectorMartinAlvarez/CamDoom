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

import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import processing.sound.*;
import peasy.*;
import queasycam.*;
import oscP5.*;

void settings() {
	size(700, 700, P3D);
	PJOGL.setIcon(CDOOM_ICON);
}

void setup() {
	surface.setLocation((displayWidth - width) / 2, (displayHeight - height) / 2);
	surface.setTitle("CamDoom");
	surface.setResizable(false);
	surface.hideCursor();
	surface.setAlwaysOnTop(true);

	loadFonts(); loadImages();
	loadSounds(); loadActions();

	oscP5 = new OscP5(this, 8338);
	map = new CDoomMap(CDOOM_MAP_OBJ, CDOOM_MAP_COLLISIONS);

	if (!MOVE_FREE_CAMERA) {
		slayer = new CDoomSlayer(CDOOM_SLAYER_X, CDOOM_SLAYER_Y, CDOOM_SLAYER_Z, this);
    face = new Face();

		CDoomColumns[] columns = loadColumns();
		CDoomStairs stairs = new CDoomStairs(CDOOM_MAP_STAIRS);
		game = new CDoomGame(map, slayer, stairs, columns, face);
		loadItems(); loadEnemies();
	} else {
		cam = new QueasyCam(this);
		cam.speed = 5;              // default is 3
		cam.sensitivity = 0.5;
	}
}

void draw() {
	background(0);
	updateSize();

	if (!MOVE_FREE_CAMERA) {
		updateActions();

		switch(gameState) {
			case 0: game.display(); 	 break;
			case 1: displayMenu();  	 break;
			case 2: displayPause(); 	 break;
			case 3: displaySettings(); break;
			case 4: displaySettings(); break;
			case 5: displayDeath(); 	 break;
		}
	} else {
		map.display();
	}
}
