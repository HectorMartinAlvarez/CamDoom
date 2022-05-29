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
	float x, y, z;

	CDoomShape(float x, float y, float z) {
		this.shape = createShape();
		this.x = x; this.y = y; this.z = z;
		this.shader = null;
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
		translate(this.x, this.y, this.z);

		if (this.shader != null) shader(this.shader);
		shape(this.shape);
		if (this.shader != null) resetShader();

		popMatrix();
	}
}
