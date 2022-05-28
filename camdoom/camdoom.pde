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
import processing.sound.*;
import queasycam.*;

void settings() {
	size(700, 700, P3D);
	PJOGL.setIcon(CDOOM_ICON);
	//fullScreen();
}

void setup() {
	surface.setLocation((displayWidth - width) / 2, (displayHeight - height) / 2);
	surface.setTitle("CamDoom");
	surface.setResizable(false);
	surface.hideCursor();
	surface.setAlwaysOnTop(true);

	loadFonts();
	loadImages();
	loadSounds();

  PVector[] column1 = new PVector[4];
  PVector[] column2 = new PVector[4];
  PVector[] column3 = new PVector[4];
  PVector[] column4 = new PVector[4];
  PVector[] column5 = new PVector[8];
  PVector[] column6 = new PVector[8];

  column1[0] = new PVector(189.7, 0, 957.7);
  column1[1] = new PVector(255.3, 0, 957.7);
  column1[2] = new PVector(255.3, 0, 1025.5);
  column1[3] = new PVector(189.7, 0, 1025.5);

  column2[0] = new PVector(-131.2, 0, 956.7);
  column2[1] = new PVector(-61.2, 0, 956.7);
  column2[2] = new PVector(-61.2, 0, 1025.5);
  column2[3] = new PVector(-131.2, 0, 1025.5);

  column3[0] = new PVector(-448.6, 0, 706.9);
  column3[1] = new PVector(-448.6, 0, 637.5);
  column3[2] = new PVector(-383.7, 0, 637.5);
  column3[3] = new PVector(-383.7, 0, 706.9);

  column4[0] = new PVector(-895.9, 0, 775.2);
  column4[1] = new PVector(-895.9, 0, 705.2);
  column4[2] = new PVector(-960.3, 0, 705.2);
  column4[3] = new PVector(-960.3, 0, 775.2);

  column5[0] = new PVector(-128.7, 0, 2235.6);
  column5[1] = new PVector(3.5, 0, 2235.6);
  column5[2] = new PVector(3.5, 0, 2309.1);
  column5[3] = new PVector(-58.5, 0, 2312.5);
  column5[4] = new PVector(-58.5, 0, 2361);
  column5[5] = new PVector(3.5, 0, 2363.9);
  column5[6] = new PVector(3.5, 0, 2435.8);
  column5[7] = new PVector(-128.7, 0, 2435.8);

  column6[0] = new PVector(-387.9, 0, 2235.6);
  column6[1] = new PVector(-387.9, 0, 2309.1);
  column6[2] = new PVector(-326.6, 0, 2309.1);
  column6[3] = new PVector(-326.6, 0, 2362.4);
  column6[4] = new PVector(-387.9, 0, 2362.5);
  column6[5] = new PVector(-387.9, 0, 2436.9);
  column6[6] = new PVector(-250.5, 0, 2436.9);
  column6[7] = new PVector(-250.5, 0, 2235.6);

  CDoomColumns[] columns = new CDoomColumns[6];
  columns[0] = new CDoomColumns(column1);
  columns[1] = new CDoomColumns(column2);
  columns[2] = new CDoomColumns(column3);
  columns[3] = new CDoomColumns(column4);
  columns[4] = new CDoomColumns(column5);
  columns[5] = new CDoomColumns(column6);

	CDoomMap map = new CDoomMap(CDOOM_MAP_OBJ, CDOOM_MAP_COLLISIONS);
  CDoomStairs stairs = new CDoomStairs(CDOOM_MAP_STAIRS);
	CDoomSlayer slayer = new CDoomSlayer(113.5, -100, 762.8, this);
	game = new CDoomGame(map, slayer, stairs, columns);
}

void draw() {
	background(0);
	updateSize();

	switch(gameState) {
		case 0: game.display(); 	 break;
		case 1: displayMenu();  	 break;
		case 2: displayPause(); 	 break;
		case 3: displaySettings(); break;
		case 4: displaySettings(); break;
	}
}
