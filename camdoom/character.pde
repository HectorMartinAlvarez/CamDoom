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

enum CDoomSlayerStatus { SLAYER_NORMAL, SLAYER_ATTACK, SLAYER_PAIN };

abstract class CDoomCharacter {
	PVector pos;
	boolean isVisible;

	CDoomCharacter(float x, float y, float z) {
		this.pos = new PVector(x, y, z);
		this.isVisible = true;
	}

	float x() { return this.pos.x; }
	float y() { return this.pos.y; }
	float z() { return this.pos.z; }

	void setx(float x) { this.pos.x = x; }
	void sety(float y) { this.pos.y = y; }
	void setz(float z) { this.pos.z = z; }

	void setVisible(boolean isVisible) {
		this.isVisible = isVisible;
	}

	abstract void display();
}

// -----------------------------
// Slayer
// -----------------------------

class CDoomSlayer extends CDoomCharacter {
	final camdoom papplet;
	PVector prevPos, bounce;
	boolean[] bounceDirection;

	int health, shield, angle;
	CDoomSlayerStatus status;
	boolean spriteFinished, isMoving;

  final PeasyCam camera;
  float[][] prevColumn = new float[3][6];

	CDoomSlayer(float x, float y, float z, camdoom papplet) {
		super(x, y, z);

		this.papplet = papplet;
		this.prevPos = new PVector(x(), y(), z());
		this.bounce = new PVector(0, 0);
		this.bounceDirection = new boolean[2];

		this.status = CDoomSlayerStatus.SLAYER_NORMAL;
		this.health = CDOOM_MAX_HEALTH;
		this.shield = CDOOM_MIN_SHIELD;
		this.spriteFinished = true;

		this.camera = new PeasyCam(this.papplet, x(), y(), z(), 50);
    this.camera.setDistance(50);
    this.camera.setActive(false);
		this.camera.setWheelHandler(null);

    for(int i = 0; i < this.prevColumn.length; i++) {
      this.prevColumn[0][i] = x();
      this.prevColumn[1][i] = y();
      this.prevColumn[2][i] = z();
    }

    rotateCamera(180);
		restorePosition();
	}

	void reset() {
		this.pos = new PVector(CDOOM_SLAYER_X, CDOOM_SLAYER_Y, CDOOM_SLAYER_Z);
		this.prevPos = new PVector(CDOOM_SLAYER_X, CDOOM_SLAYER_Y, CDOOM_SLAYER_Z);
		this.bounce = new PVector(0, 0);
		this.bounceDirection = new boolean[2];

		this.status = CDoomSlayerStatus.SLAYER_NORMAL;
		this.health = CDOOM_MAX_HEALTH;
		this.shield = CDOOM_MIN_SHIELD;
		this.spriteFinished = true;

		this.camera.reset();
		this.camera.lookAt(x(), y(), z());
		this.camera.setDistance(50);
    this.camera.setActive(false);
		this.camera.setWheelHandler(null);

    for(int i = 0; i < this.prevColumn.length; i++) {
      this.prevColumn[0][i] = x();
      this.prevColumn[1][i] = y();
      this.prevColumn[2][i] = z();
    }

		this.angle = 0;
    rotateCamera(180);
		restorePosition();
	}

	void setShield(int shield) {
		if (shield >= 0 && shield <= 100) {
			if (this.shield < shield) itemTakenSound.play();
			else this.status = CDoomSlayerStatus.SLAYER_PAIN;
			this.shield = shield;
		}
	}

	void bouncing() {
		if (this.isMoving) {
			if (bounceDirection[0]) bounce.x += 0.1; else bounce.x -= 0.1;
			if (bounceDirection[1]) bounce.y += 0.1; else bounce.y -= 0.1;
			if (bounce.x > 8 || bounce.x < 0) bounceDirection[0] = !bounceDirection[0];
			if (bounce.y > 4 || bounce.y < 0) bounceDirection[1] = !bounceDirection[1];
		} else {
			bounce = new PVector(0, 0);
		}
	}

	void doDamage() {
		this.status = CDoomSlayerStatus.SLAYER_PAIN;
		this.health = this.health - 10;
	}

	void display() {
		displaySlayerGU(); camera.beginHUD();
		float w = shotgun.width, h = shotgun.height;

		switch(this.status) {
			case SLAYER_NORMAL:
				image(shotgun, (width - w) / 2 - 40 + bounce.x, height - h + bounce.y, w, h);
				this.bouncing();
			break;

			case SLAYER_ATTACK:
				// Prepare Sprite
				if (this.spriteFinished) {
					shotgunShoot.setPlaying(true, (width - w) / 2 - 40 + bounce.x, height - h + bounce.y);
					this.spriteFinished = false;
					shootSound.play();
					this.bouncing();
				}

				// Play Sprite
				else if (shotgunShoot.isPlaying) {
					shotgunShoot.play();

					if (shotgunShoot.numFrame == 3) {
						if (!prepareAmmoSound.isPlaying()) {
							prepareAmmoSound.play();
						}
					}
				}

				// Finish Sprite
				else {
					this.spriteFinished = true;
					this.status = CDoomSlayerStatus.SLAYER_NORMAL;
				}
			break;

			case SLAYER_PAIN:
				image(shotgun, (width - w) / 2 - 40 + bounce.x, height - h + bounce.y, w, h);
				this.bouncing();

				if (this.health > 0) {
					if (!painSound.isPlaying()) {
						painSound.play();
						this.status = CDoomSlayerStatus.SLAYER_NORMAL;
					}
				} else {
					painSound.stop(); deathSound.play();
					this.status = CDoomSlayerStatus.SLAYER_NORMAL;
					game.reset(); gameState = 5;
				}
			break;
		}

		displayBloodEffects();
		camera.endHUD();
	}

	void setYAxis(float y) { this.sety(y); }

  void restorePosition() {
		this.pos = new PVector(this.prevPos.x, this.prevPos.y, this.prevPos.z);
    camera.lookAt(x(), y(), z());
  }

  void savePosition() {
    float[] posValues = camera.getLookAt();
		this.prevPos = new PVector(posValues[0], posValues[1], posValues[2]);
  }

  void restoreColumnsPosition(int index) {
		this.pos = new PVector(this.prevPos.x, this.prevPos.y, this.prevPos.z);
    camera.lookAt(prevColumn[0][index], prevColumn[1][index], prevColumn[2][index]);
  }

  void saveColumnsPosition(int index){
    float[] posValues = camera.getLookAt();
		prevColumn[0][index] = posValues[0];
		prevColumn[1][index] = posValues[1];
		prevColumn[2][index] = posValues[2];
  }

  void rotateCamera(float angle) {
    camera.rotateY(radians(angle));
    this.angle += angle;

    if (this.angle > 360 || this.angle < -360) {
      this.angle = round(this.angle / 360) + (this.angle < 0 ? 1 : -1);
    }
  }

  void moveSlayer() {
    float c1 = sin(radians(this.angle)) * 10;
    float c2 = sqrt((25) - (c1 * c1)) * 2;
		this.setx(x() - c1);

		boolean cond1 = (abs(this.angle) > 90 && abs(this.angle) <= 180);
		boolean cond2 = (abs(this.angle) > 180 && abs(this.angle) <= 270);

		if (cond1 || cond2) this.setz(z() + c2);
		else this.setz(z() - c2);

    this.camera.lookAt(x(), y(), z());
		this.savePosition();
  }
}

// -----------------------------
// Enemy
// -----------------------------

class CDoomEnemy extends CDoomCharacter {
	float time;
  boolean shoot;

	CDoomEnemy(float x, float y, float z) {
		super(x, y, z);
		this.time = 0;
		this.shoot = true;
	}

	boolean inRange(float px, float pz) {
		float distX = px - this.x(), distZ = pz - this.z();
		float distance = sqrt((distX * distX) + (distZ * distZ));
		return distance <= 250;
	}

	void display() {
		if (this.isVisible) {
			// ...
			// not for now
		}
	}

	void move(float x, float y, float z) {

  }
}
