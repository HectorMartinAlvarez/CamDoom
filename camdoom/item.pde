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

abstract class CDoomItem {
	final PVector pos;
	boolean isVisible;

	CDoomItem(float x, float y, float z) {
		this.pos = new PVector(x, y, z);
		this.isVisible = true;
	}

	float x() { return this.pos.x; }
	float y() { return this.pos.y; }
	float z() { return this.pos.z; }

	void setVisible(boolean isVisible) {
		this.isVisible = isVisible;
	}

	abstract void apply();

	abstract void display();
}

class MedicalKitCDoomItem extends CDoomItem {
	CDoomSlayer slayer;

	MedicalKitCDoomItem(float x, float y, float z, CDoomSlayer slayer) {
		super(x, y, z);
		this.slayer = slayer;
	}

	void apply() {



	}

	void display() {

	}
}
