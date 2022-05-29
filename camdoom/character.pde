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
	float x, y, z;
	boolean isVisible;

	CDoomCharacter(float x, float y, float z) {
		this.x = x; this.y = y; this.z = z;
		this.isVisible = true;
	}

	void setVisible(boolean isVisible) {
		this.isVisible = isVisible;
	}

	abstract void display();
}

// -----------------------------
// Slayer
// -----------------------------

class CDoomSlayer extends CDoomCharacter {
	camdoom papplet;

	int health, shield;
	CDoomSlayerStatus status;
	boolean spriteFinished;

  PeasyCam camera;
  float angle, previousX, previousY, previousZ;
  float[] previousColumnX = new float[6];
  float[] previousColumnY = new float[6];
  float[] previousColumnZ = new float[6];

	CDoomSlayer(float x, float y, float z, camdoom t) {
		super(x, y, z);

		this.papplet = t;
		this.health = 100; this.shield = 0;
		this.status = CDoomSlayerStatus.SLAYER_NORMAL;
		this.spriteFinished = true;

		previousX = x; previousY = y; previousZ = z;
		camera = new PeasyCam(this.papplet, x, y, z, 50);
    camera.setDistance(50);
    camera.setActive(false);
		camera.setWheelHandler(null);

    for(int i = 0; i < previousColumnX.length; i++) {
      previousColumnX[i] = x;
      previousColumnY[i] = y;
      previousColumnZ[i] = z;
    }

    rotateCamera(180);
		restorePosition();
	}

	void reset() {
		this.x = 113.5; this.y = -100; this.z = 762.8;
		this.health = 100; this.shield = 0;
		this.status = CDoomSlayerStatus.SLAYER_NORMAL;
		this.spriteFinished = true;

		previousX = x; previousY = y; previousZ = z;
		camera = new PeasyCam(this.papplet, x, y, z, 50);
    camera.setDistance(50);
    camera.setActive(false);
		camera.setWheelHandler(null);

    for(int i = 0; i < previousColumnX.length; i++) {
      previousColumnX[i] = x;
      previousColumnY[i] = y;
      previousColumnZ[i] = z;
    }

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

	void doDamage() {
		this.status = CDoomSlayerStatus.SLAYER_PAIN;
		this.health = this.health - 10;
	}

	void display() {
		displaySlayerGU(); camera.beginHUD();
		float w = shotgun.width, h = shotgun.height;

		switch(this.status) {
			case SLAYER_NORMAL:
				image(shotgun, (width - w) / 2 - 40, height - h, w, h);
			break;

			case SLAYER_ATTACK:
				// Prepare Sprite
				if (this.spriteFinished) {
					shotgunShoot.setPlaying(true, (width - w) / 2 - 40, height - h);
					this.spriteFinished = false;
					shootSound.play();
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
				image(shotgun, (width - w) / 2 - 40, height - h, w, h);

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

  void restorePosition() {
    this.x = previousX;
    this.y = previousY;
    this.z = previousZ;
    camera.lookAt(previousX, previousY, previousZ);
  }

  void savePosition() {
    float[] pos = camera.getLookAt();
    previousX = pos[0];
    previousY = pos[1];
    previousZ = pos[2];
  }

  void restoreColumnsPosition(int index) {
		this.x = previousX;
    this.y = previousY;
    this.z = previousZ;
    camera.lookAt(previousColumnX[index], previousColumnY[index], previousColumnZ[index]);
  }

  void saveColumnsPosition(int index){
    float[] pos = camera.getLookAt();
    previousColumnX[index] = pos[0];
    previousColumnY[index] = pos[1];
    previousColumnZ[index] = pos[2];
  }

  void rotateCamera(float angle) {
    camera.rotateY(radians(angle));
    this.angle += angle;

    if(this.angle > 360 || this.angle < -360) {
      this.angle = round(this.angle/360)+(this.angle<0 ? 1 : -1);
    }
  }

  void setYAxis(float y) {
		this.y = y;
  }

  void moveSlayer() {
    float c1 = sin(radians(this.angle)) * 5;
    float c2 = sqrt((25) - (c1 * c1));

    if(abs(this.angle) <= 90) {
      this.x -= c1; this.z -= c2;
    } else if(abs(this.angle) > 90 && abs(this.angle) <= 180) {
      this.x -= c1; this.z += c2;
    } else if(abs(this.angle) > 180 && abs(this.angle) <= 270) {
      this.x -= c1; this.z += c2;
    } else {
      this.x -= c1; this.z -= c2;
    }

    camera.lookAt(this.x, this.y, this.z);
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
		float distX = px - this.x, distZ = pz - this.z;
		float distance = sqrt((distX*distX) + (distZ*distZ));
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
