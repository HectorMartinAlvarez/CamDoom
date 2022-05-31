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

interface CDoomAnimation {
	void setPlaying(boolean isPlaying);
	void play();
}

class ModelCDoomAnimation implements CDoomAnimation {
	final PImage[] images;
	CDoomShape model;
	CDoomTimer timer;
	boolean isPlaying;
	int numFrame, delay;

	ModelCDoomAnimation(String dir, CDoomShape model, int delay) {
		dir = sketchPath() + "/" + dir;
		this.images = imagesFromDirectory(dir);
		this.timer = new CDoomTimer();
		this.model = model;
		this.isPlaying = false;
		this.delay = delay;
		this.numFrame = 0;
	}

	void setPlaying(boolean isPlaying) {
		this.isPlaying = isPlaying;

		if (isPlaying) {
			this.numFrame = 0;
			this.model.setTexture(images[0]);
			this.timer.setTime(this.delay);
		}
	}

	void play() {
		if (this.isPlaying == true) {
			this.model.setTexture(images[this.numFrame]);
			this.model.display();
			this.timer.run();

			if (this.timer.hasFinished) {
				this.numFrame = this.numFrame + 1;
				this.timer.setTime(this.delay);
			}

			if (this.numFrame >= this.images.length) {
				this.timer.stop();
				this.isPlaying = false;
				this.numFrame = 0;
			}
		}
	}
}

class ImageCDoomAnimation implements CDoomAnimation {
	final PImage[] images;
	CDoomTimer timer;
	boolean isPlaying;
	int numFrame, delay;
	PVector pos, dim;

	ImageCDoomAnimation(String dir, float w, float h, int delay) {
		this.pos = new PVector(0, 0);
		this.dim = new PVector(w, h);

		dir = sketchPath() + "/" + dir;
		this.images = imagesFromDirectory(dir);
		this.timer = new CDoomTimer();
		this.isPlaying = false;
		this.delay = delay;
		this.numFrame = 0;
	}

	void setLocation(float x, float y) {
		this.pos = new PVector(x, y);
	}

	void setPlaying(boolean isPlaying) {
		this.isPlaying = isPlaying;

		if (isPlaying) {
			this.numFrame = 0;
			this.timer.setTime(this.delay);
		}
	}

	void play() {
		if (this.isPlaying == true) {
			PImage img = this.images[this.numFrame];
			image(img, this.pos.x, this.pos.y, this.dim.x, this.dim.y);
			this.timer.run();

			if (this.timer.hasFinished) {
				this.numFrame = this.numFrame + 1;
				this.timer.setTime(this.delay);
			}

			if (this.numFrame >= this.images.length) {
				this.timer.stop();
				this.isPlaying = false;
				this.pos = new PVector(0, 0);
				this.numFrame = 0;
			}
		}
	}
}
