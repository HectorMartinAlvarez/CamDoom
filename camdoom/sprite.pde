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
	PVector pos, dim;
	int numSprite;

	CDoomSprite(String dir, float w, float h) {
		this.images = imagesFromDirectory(sketchPath() + "/" + dir);
		this.pos = new PVector(0, 0);
		this.dim = new PVector(w, h);
		this.numSprite = 0;
	}

	void display() {
		if (this.numSprite >= 0 && this.numSprite < this.images.length) {
			PImage img = this.images[this.numSprite];
			pushStyle(); noStroke();
			image(img, this.pos.x, this.pos.y, this.dim.x, this.dim.y);
			popStyle();
		} else this.numSprite = 0;
	}
}

PImage[] imagesFromDirectory(String dir) {
	File directoryPath = new File(dir);
	PImage[] images = null;

	if (directoryPath.exists()) {
		if (directoryPath.isDirectory()) {
			File[] filesList = directoryPath.listFiles();
			images = new PImage[filesList.length];

			for (int i = 0; i < images.length; i++) {
				String filename = filesList[i].getAbsolutePath();
				images[i] = loadImage(filename);
			}
		} else if (directoryPath.isFile()) {
			images = new PImage[1];
			images[0] = loadImage(dir);
		}
	}

	return images;
}
