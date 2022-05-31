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

abstract class CDoomShape {
	PShape shape;
	PShader shader;
	PImage texture;
	float x, y, z, angle;

	CDoomShape(float x, float y, float z) {
		this.shape = createShape();
		this.x = x; this.y = y; this.z = z;
		this.shader = null;
	}

	void setAngle(float angle) {
		this.angle = angle;
	}

	void setTexture(PImage textureImage) {
		if (textureImage != null) {
			this.texture = textureImage;
			this.shape.setTexture(this.texture);
		}
	}

	void setTexture(String texturePath) {
		if (texturePath != null) {
			this.texture = loadImage(texturePath);
			this.shape.setTexture(this.texture);
		}
	}

	void setShader(String shaderPath) {
		if (shaderPath != null) {
			this.shader = loadShader(shaderPath);
		}
	}

	void applyShader(ApplyShader applyShader) {
		if (applyShader != null && this.shader != null) {
			applyShader.apply(this.shader);
		}
	}

	void display() {
		pushMatrix(); 
    pushStyle();
		translate(this.x, this.y, this.z);
		noStroke(); noFill();
    rotateY(radians(slayer.angle));
		shape(this.shape);

		popStyle(); 
    popMatrix();
	}
}

class ImageCDoomShape extends CDoomShape {
	float width, height, angle;

	ImageCDoomShape(float x, float y, float z, float width, float height) {
		super(x, y, z);
		this.width = width;
		this.height = height;
    this.shape = createShape(RECT, 0, 0, this.width, this.height);
		this.shape.setStroke(color(255, 255, 255, 0));
	}

	void setTexture(PImage textureImage) {
		if (textureImage != null) {
			this.texture = textureImage;
			this.texture.resize((int)this.width, (int)this.height);
			this.shape.setTexture(this.texture);
		}
	}

	void setTexture(String texturePath) {
		if (texturePath != null) {
			this.texture = loadImage(texturePath);
			this.texture.resize((int)this.width, (int)this.height);
			this.shape.setTexture(this.texture);
		}
	}
}

class CubeCDoomShape extends CDoomShape {
	float slide;

	CubeCDoomShape(float x, float y, float z, float slide) {
		super(x, y, z);
		this.slide = slide;
    this.shape = createShape(BOX, this.slide, this.slide, this.slide);
		this.shape.setStroke(color(255, 255, 255, 0));
	}
}

class RectangleCDoomShape extends CDoomShape {
	float width, height, depthWidth, depthHeight;

	RectangleCDoomShape(float x, float y, float z, float width, float height, float depthWidth, float depthHeight) {
		super(x, y, z);
		this.width = width;
		this.height = height;
		this.depthWidth = depthWidth;
		this.depthHeight = depthHeight;
    this.shape = createShape(RECT, this.width, this.height, this.depthWidth, this.depthHeight);
		this.shape.setStroke(color(255, 255, 255, 0));
	}
}
