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

// ~ Stadistics ~
static final int CDOOM_MAX_HEALTH_SLAYER = 100;
static final int CDOOM_MAX_HEALTH_ENEMY = 50;
static final int CDOOM_MIN_HEALTH = 0;

static final int CDOOM_MAX_SHIELD = 100;
static final int CDOOM_MIN_SHIELD = 0;

static final int CDOOM_DAMAGE_SLAYER = 30;
static final int CDOOM_DAMAGE_ENEMY = 10;

// ~ Slayer ~
static final float CDOOM_SLAYER_X = 113.5;
static final float CDOOM_SLAYER_Y = -100;
static final float CDOOM_SLAYER_Z = 762.8;

enum CDoomSlayerStatus {
	SLAYER_NORMAL,			// just holding the shotgun
	SLAYER_ATTACK,			// attacking whit the shotgun
	SLAYER_PAIN					// damage received
};

// ~ Image paths ~
static final String CDOOM_ICON = "data/images/icon.png";
static final String CDOOM_MAIN_MENU_BACKGROUND = "data/images/main_menu.jpg";

// ~ Map paths ~
static final String CDOOM_MAP_OBJ = "data/map/e1m1/doom2_e1m1.obj";
static final String CDOOM_MAP_COLLISIONS = "data/map/e1m1/doom2_e1m1_collisions.csv";
static final String CDOOM_MAP_STAIRS = "data/map/e1m1/doom2_e1m1_stairs.csv";

// ~ Font paths ~
static final String CDOOM_FONT_TITLE = "data/fonts/amazdoomleft.ttf";
static final String CDOOM_FONT_TEXT = "data/fonts/doom2016text_golbq.ttf";

// ~ Sounds/Music files ~
static final String CDOOM_E1M1 = "data/sounds/e1m1.wav";
static final String CDOOM_CONFIRM = "data/sounds/pistol.wav";
static final String CDOOM_SELECT = "data/sounds/pstop.wav";
static final String CDOOM_EXIT = "data/sounds/posit1.wav";
static final String CDOOM_SHOT = "data/sounds/shotgn.wav";
static final String CDOOM_PREPARE_AMMO = "data/sounds/sgcock.wav";
static final String CDOOM_PAIN = "data/sounds/plpain.wav";
static final String CDOOM_DEATH = "data/sounds/pldeth.wav";
static final String CDOOM_ITEM_TAKEN = "data/sounds/itemup.wav";

// ~ Sprites and Animation files ~
static final String CDOOM_BLOOD_EFFECT = "data/animation/blood_effect";
static final String CDOOM_SHOTGUN_PREPARING = "data/animation/shotgun";
static final String CDOOM_SHOTGUN = "data/images/shotgun.png";
static final String CDOOM_SHOOT_SHOTGUN = "data/images/shotgun.png";

// -----------------------------------------------
// Variables
// -----------------------------------------------

// ~ Window ~
int current_width = width;
int current_height = height;

// ~ Sounds ~
SoundFile e1m1Music;
SoundFile confirmSound, exitSound, selectSound;
SoundFile shootSound, prepareAmmoSound;
SoundFile painSound, deathSound;
SoundFile itemTakenSound;

float volumeEffects = 1.0;		// 0 - mute, 1 - max volume
float volumeMusic = 0.2;			// 0 - mute, 1 - max volume

// ~ GUI ~
PImage backgroundImage;
PFont titleFont, basicTextFont;

// ~ Sprites and Animation ~
CDoomAnimation shotgunShoot;
CDoomSprite bloodEffect;
PImage shotgun;

// ~ CDoom ~
CDoomGame game;
CDoomSlayer slayer;
CDoomMap map;

// ~ States ~
int selectedOption = 0;		// 0..n options
int gameState = 1;				// 0 - start game
													// 1 - main menu
													// 2 - pause menu
													// 3 - settings from main menu
													// 4 - settings from pause menu
													// 5 - death message

// ~ Controls ~
Map<Character, Boolean> actions;

// -----------------------------------------------
// Loaders
// -----------------------------------------------

void updateSize() {
	if (current_width != width || current_height != height) {
		current_width = width; current_height = height;
		backgroundImage.resize(width, height);
		bloodEffect.dim = new PVector(width, height);
	}
}

void loadSounds() {
	e1m1Music = new SoundFile(this, CDOOM_E1M1);
	confirmSound = new SoundFile(this, CDOOM_CONFIRM);
	selectSound = new SoundFile(this, CDOOM_SELECT);
	exitSound = new SoundFile(this, CDOOM_EXIT);
	shootSound = new SoundFile(this, CDOOM_SHOT);
	prepareAmmoSound = new SoundFile(this, CDOOM_PREPARE_AMMO);
	painSound = new SoundFile(this, CDOOM_PAIN);
	deathSound = new SoundFile(this, CDOOM_DEATH);
	itemTakenSound = new SoundFile(this, CDOOM_ITEM_TAKEN);

	adjustVolumeForMusic();
	adjustVolumeForEffects();
	e1m1Music.loop();
}

void loadFonts() {
	titleFont = createFont(CDOOM_FONT_TITLE, 200);
	basicTextFont = createFont(CDOOM_FONT_TEXT, 30);
}

void loadImages() {
	backgroundImage = loadImage(CDOOM_MAIN_MENU_BACKGROUND);
	backgroundImage.resize(width, height);
	backgroundImage.filter(BLUR, 2);

	shotgun = loadImage(CDOOM_SHOTGUN);
	shotgun.resize(shotgun.width * 3, shotgun.height * 3);

	shotgunShoot = new CDoomAnimation(
		CDOOM_SHOTGUN_PREPARING,
		shotgun.width, shotgun.height, 3
	);

	bloodEffect = new CDoomSprite(
		CDOOM_BLOOD_EFFECT,
		width, height
	);
}

CDoomColumns[] loadColumns() {
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

	return columns;
}

void loadActions() {
	actions = new HashMap<Character, Boolean>();
	actions.put('W', false); actions.put('w', false);
	actions.put('A', false); actions.put('a', false);
	actions.put('D', false); actions.put('d', false);
}
