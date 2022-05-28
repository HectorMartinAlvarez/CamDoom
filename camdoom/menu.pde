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
	background(backgroundImage);
	pushMatrix(); pushStyle();

	textMode(SHAPE); fill(255, 255, 255); translate(0, 280);
	textFont(createFont(CDOOM_FONT_TITLE, 200));

	float x = (width - textWidth("CamDoom")) / 2;
	text("CamDoom", x, 0);

	textFont(createFont(CDOOM_FONT_TEXT, 30));

	pushStyle(); translate(0, 80); checkOption(0);
	x = (width - textWidth("Start Game")) / 2;
	text("Start Game", x, 0);
	popStyle();

	pushStyle(); translate(0, 60); checkOption(1);
	x = (width - textWidth("Settings")) / 2;
	text("Settings", x, 0);
	popStyle();

	pushStyle(); translate(0, 60); checkOption(2);
	x = (width - textWidth("Exit Game")) / 2;
	text("Exit Game", x, 0);
	popStyle();

	popStyle(); popMatrix();
}

void displayPause() {
	game.map.display();

	pushMatrix(); pushStyle();

	textMode(SHAPE); fill(255, 255, 255); translate(0, 280);
	textFont(createFont(CDOOM_FONT_TITLE, 200));

	float x = (width - textWidth("CamDoom")) / 2;
	text("CamDoom", x, 0);

	textFont(createFont(CDOOM_FONT_TEXT, 30));

	pushStyle(); translate(0, 80); checkOption(0);
	x = (width - textWidth("Resume Game")) / 2;
	text("Resume Game", x, 0);
	popStyle();

	pushStyle(); translate(0, 60); checkOption(1);
	x = (width - textWidth("Settings")) / 2;
	text("Settings", x, 0);
	popStyle();

	pushStyle(); translate(0, 60); checkOption(2);
	x = (width - textWidth("Go back")) / 2;
	text("Go back", x, 0);
	popStyle();

	popStyle(); popMatrix();
}

void checkOption(int numOption) {
	if (numOption == selectedOption) {
		fill(0, 0, 0);
	}
}
