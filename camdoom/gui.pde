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

void displayMenu() {
	game.slayer.camera.beginHUD();
	background(backgroundImage);
	pushMatrix(); pushStyle();

	textMode(SHAPE); fill(255, 255, 255); translate(0, 280);
	textFont(titleFont);

	float x = (width - textWidth("CamDoom")) / 2;
	text("CamDoom", x, 0);

	textFont(basicTextFont);

	pushStyle(); translate(0, 80); if (0 == selectedOption) fill(0, 0, 0);
	x = (width - textWidth("Start Game")) / 2;
	text("Start Game", x, 0);
	popStyle();

	pushStyle(); translate(0, 60); if (1 == selectedOption) fill(0, 0, 0);
	x = (width - textWidth("Settings")) / 2;
	text("Settings", x, 0);
	popStyle();

	pushStyle(); translate(0, 60); if (2 == selectedOption) fill(0, 0, 0);
	x = (width - textWidth("Exit Game")) / 2;
	text("Exit Game", x, 0);
	popStyle();

	popStyle(); popMatrix();
	game.slayer.camera.endHUD();
}

void displayPause() {
	game.map.display();
	game.slayer.camera.beginHUD();

	pushMatrix(); pushStyle();

	textMode(SHAPE); fill(255, 255, 255); translate(0, 280);
	textFont(titleFont);

	float x = (width - textWidth("CamDoom")) / 2;
	text("CamDoom", x, 0);

	textFont(basicTextFont);

	pushStyle(); translate(0, 80); if (0 == selectedOption) fill(0, 0, 0);
	x = (width - textWidth("Resume Game")) / 2;
	text("Resume Game", x, 0);
	popStyle();

	pushStyle(); translate(0, 60); if (1 == selectedOption) fill(0, 0, 0);
	x = (width - textWidth("Settings")) / 2;
	text("Settings", x, 0);
	popStyle();

	pushStyle(); translate(0, 60); if (2 == selectedOption) fill(0, 0, 0);
	x = (width - textWidth("Go back")) / 2;
	text("Go back", x, 0);
	popStyle();

	popStyle(); popMatrix();
	game.slayer.camera.endHUD();
}

void displaySettings() {
	if (gameState == 3) {
		game.slayer.camera.beginHUD();
		background(backgroundImage);
	} else {
		game.map.display();
		game.slayer.camera.beginHUD();
	}

	pushMatrix(); pushStyle();

	textMode(SHAPE); fill(255, 255, 255); translate(0, 280);
	textFont(titleFont);

	float x = (width - textWidth("CamDoom")) / 2;
	text("CamDoom", x, 0);

	textFont(basicTextFont);

	pushStyle(); translate(0, 80); if (0 == selectedOption) fill(0, 0, 0);
	x = (width - textWidth("Adjust Music: " + int(volumeMusic * 100))) / 2;
	text("Adjust Music: " + int(volumeMusic * 100), x, 0);
	popStyle();

	pushStyle(); translate(0, 60); if (1 == selectedOption) fill(0, 0, 0);
	x = (width - textWidth("Adjust Sounds: " + int(volumeEffects * 100))) / 2;
	text("Adjust Sounds: " + int(volumeEffects * 100), x, 0);
	popStyle();

	pushStyle(); translate(0, 60); if (2 == selectedOption) fill(0, 0, 0);
	x = (width - textWidth("Go back")) / 2;
	text("Go back", x, 0);
	popStyle();

	popStyle(); popMatrix();
	game.slayer.camera.endHUD();
}

void displaySlayerGU() {
	game.slayer.camera.beginHUD();

	pushStyle();
	textFont(basicTextFont);
	fill(255, 255, 255);

	text("Health: " + game.slayer.health, 20, height - 40);
	text("Shield: " + game.slayer.shield, 20, height - 20);
	popStyle();

	pushStyle();
	stroke(255, 255, 255);
	line(width / 2 - 10, height / 2, width / 2 + 10, height / 2);
	line(width / 2, height / 2 - 10, width / 2, height / 2 + 10);
	popStyle();

	game.slayer.camera.endHUD();
}

void displayDeath() {
	game.map.display();
	game.slayer.camera.beginHUD();

	pushMatrix(); pushStyle();

	textMode(SHAPE); fill(255, 255, 255); translate(0, 280);
	textFont(titleFont);

	float x = (width - textWidth("Defeat")) / 2;
	text("Defeat", x, 0);

	textFont(basicTextFont);

	pushStyle(); translate(0, 80); if (0 == selectedOption) fill(0, 0, 0);
	x = (width - textWidth("Retry")) / 2;
	text("Retry", x, 0);
	popStyle();

	pushStyle(); translate(0, 60); if (1 == selectedOption) fill(0, 0, 0);
	x = (width - textWidth("Go back")) / 2;
	text("Go back", x, 0);
	popStyle();

	popStyle(); popMatrix();
	game.slayer.camera.endHUD();
}

void displayBloodEffects() {
	game.slayer.camera.beginHUD();
	int healthValue = game.slayer.health;

	if (healthValue > 80 && healthValue <= 90) {
		bloodEffect.numSprite = 0;
		bloodEffect.display();
	}

	else if (healthValue > 50 && healthValue <= 80) {
		bloodEffect.numSprite = 1;
		bloodEffect.display();
	}

	else if (healthValue > 30 && healthValue <= 50) {
		bloodEffect.numSprite = 2;
		bloodEffect.display();
	}

	else if (healthValue <= 30) {
		bloodEffect.numSprite = 3;
		bloodEffect.display();
	}

	game.slayer.camera.endHUD();
}
