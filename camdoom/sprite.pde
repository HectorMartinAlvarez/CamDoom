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

class CDoomSprite {
	final PImage[] images;
	CDoomTimer delayTimer;
	int numSprite, delayValue;
	PVector pos, dim;
	boolean isPlaying;

	CDoomSprite(String spriteDir, float w, float h, int delayValue) {
		this.images = imagesFromDirectory(sketchPath() + "/" + spriteDir);
		this.pos = new PVector(0, 0);
		this.dim = new PVector(w, h);
		this.isPlaying = false;
		this.numSprite = 0;

		this.delayValue = delayValue;
		this.delayTimer = new CDoomTimer();
		this.delayTimer.setTime(this.delayValue);
	}

	void setPlaying(boolean isPlaying, float x, float y) {
		if (isPlaying == false) {
			this.numSprite = 0;
			this.pos = new PVector(0, 0);
		} else {
			this.isPlaying = isPlaying;
			this.pos = new PVector(x, y);
			this.delayTimer.setTime(this.delayValue);
		}
	}

	void play() {
		if (this.isPlaying == true) {
			PImage img = this.images[this.numSprite];
			image(img, this.pos.x, this.pos.y, this.dim.x, this.dim.y);
			this.delayTimer.run();

			if (this.delayTimer.hasFinished) {
				this.numSprite = this.numSprite + 1;
				this.delayTimer.setTime(this.delayValue);
			}

			if (this.numSprite >= this.images.length) {
				this.delayTimer.stop();
				this.isPlaying = false;
				this.pos = new PVector(0, 0);
				this.numSprite = 0;
			}
		}
	}
}

PImage[] imagesFromDirectory(String dir) {
	File directoryPath = new File(dir);
	File[] filesList = directoryPath.listFiles();
	PImage[] images = new PImage[filesList.length];

	for(int i = 0; i < images.length; i++) {
		String filename = filesList[i].getAbsolutePath();
		images[i] = loadImage(filename);
	}

	return images;
}
