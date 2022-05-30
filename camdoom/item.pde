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
		if ((this.slayer.stats.health.y - this.slayer.stats.health.z) >= CDOOM_HEALTH_ITEM) {
			this.slayer.stats.health.z += CDOOM_HEALTH_ITEM;
			this.setVisible(false);
			itemTakenSound.play();

			if (this.slayer.stats.health.z > this.slayer.stats.health.y) {
				this.slayer.stats.health.z = this.slayer.stats.health.y;
			}
		}
	}

	void display() {
		if (this.isVisible) {
			image(medicineKit, this.pos.x, this.pos.y);
		}
	}
}

class BulletproofVestCDoomItem extends CDoomItem {
	CDoomSlayer slayer;

	BulletproofVestCDoomItem(float x, float y, float z, CDoomSlayer slayer) {
		super(x, y, z);
		this.slayer = slayer;
	}

	void apply() {
		if ((this.slayer.stats.shield.y - this.slayer.stats.shield.z) >= CDOOM_SHIELD_ITEM) {
			this.slayer.stats.shield.z += CDOOM_SHIELD_ITEM;
			itemTakenSound.play();
			this.setVisible(false);

			if (this.slayer.stats.shield.z > this.slayer.stats.shield.y) {
				this.slayer.stats.shield.z = this.slayer.stats.shield.y;
			}
		}
	}

	void display() {
		if (this.isVisible) {
			image(bulletproofVest, this.pos.x, this.pos.y);
		}
	}
}
