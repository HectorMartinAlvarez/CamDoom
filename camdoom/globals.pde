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

// -----------------------------------------------
// Constants
// -----------------------------------------------

// ~ Image paths ~
static final String CDOOM_ICON = "data/icon.png";
static final String CDOOM_MAIN_MENU_BACKGROUND = "data/main_menu.jpg";

// ~ Map paths ~
static final String CDOOM_MAP_OBJ = "data/map/doom2_MAP01_mod.obj";
static final String CDOOM_MAP_COLLISIONS = "data/map/collisions_MAP01.csv";
static final String CDOOM_MAP_STAIRS = "data/map/stairs.csv";

// ~ Font paths ~
static final String CDOOM_FONT_TITLE = "data/fonts/amazdoomleft.ttf";
static final String CDOOM_FONT_TEXT = "data/fonts/doom2016text_golbq.ttf";

// ~ Sounds/Music files ~
static final String CDOOM_E1M1 = "data/sounds/e1m1.wav";
static final String CDOOM_CONFIRM = "data/sounds/pistol.wav";
static final String CDOOM_SELECT = "data/sounds/pstop.wav";
static final String CDOOM_EXIT = "data/sounds/posit1.wav";

// -----------------------------------------------
// Variables
// -----------------------------------------------

// ~ Window ~
int current_width = width;
int current_height = height;

// ~ Sounds ~
SoundFile e1m1;
SoundFile confirm, exit, select;
float volumeSounds = 1.0;		// 0 - mute, 1 - max volume
float volumeMusic = 0.5;		// 0 - mute, 1 - max volume

// ~ GUI ~
PImage backgroundImage;
PFont titleFont, basicTextFont;

// ~ CDoom ~
CDoomGame game;

// ~ States ~
int gameState = 1;				// 0 - start game
													// 1 - main menu
													// 2 - pause menu
													// 3 - settings from main menu
													// 4 - settings from pause menu

int selectedOption = 0;		// 0 - start game
													// 1 - settings
													// 2 - go back or exit

// -----------------------------------------------
// Loaders
// -----------------------------------------------

void updateSize() {
	if (current_width != width || current_height != height) {
		current_width = width;
		current_height = height;
		backgroundImage.resize(width, height);
	}
}

void loadSounds() {
	e1m1 = new SoundFile(this, CDOOM_E1M1);
	confirm = new SoundFile(this, CDOOM_CONFIRM);
	select = new SoundFile(this, CDOOM_SELECT);
	exit = new SoundFile(this, CDOOM_EXIT);

	adjustVolumeMusic();
	adjustVolumeSounds();
	e1m1.loop();
}

void loadFonts() {
	titleFont = createFont(CDOOM_FONT_TITLE, 200);
	basicTextFont = createFont(CDOOM_FONT_TEXT, 30);
}

void loadImages() {
	backgroundImage = loadImage(CDOOM_MAIN_MENU_BACKGROUND);
	backgroundImage.resize(width, height);
	backgroundImage.filter(BLUR, 2);
}
