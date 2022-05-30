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

class CDoomStadistics {
	final PVector health, shield;
	final int damage;

	CDoomStadistics(int minHealth, int maxHealth) {
		this.health = new PVector(minHealth, maxHealth, maxHealth);
		this.shield = new PVector(0, 0, 0);
		this.damage = 0;
	}

	CDoomStadistics(int minHealth, int maxHealth, int damage) {
		this.health = new PVector(minHealth, maxHealth, maxHealth);
		this.shield = new PVector(0, 0, 0);
		this.damage = damage;
	}

	CDoomStadistics(int minHealth, int maxHealth, int minShield, int maxShield) {
		this.health = new PVector(minHealth, maxHealth, maxHealth);
		this.shield = new PVector(minShield, maxShield, minShield);
		this.damage = 0;
	}

	CDoomStadistics(int minHealth, int maxHealth, int minShield, int maxShield, int damage) {
		this.health = new PVector(minHealth, maxHealth, maxHealth);
		this.shield = new PVector(minShield, maxShield, minShield);
		this.damage = damage;
	}

	void setHealth(int health) {
		if (health >= this.health.x && health <= this.health.y) {
			this.health.z = health;
		}
	}

	void setShield(int shield) {
		if (shield >= this.shield.x && shield <= this.shield.y) {
			this.shield.z = shield;
		}
	}

	void damageReceived(int damage) {
		if (this.shield.z == this.shield.x) {
			this.health.z = this.health.z - damage;
			if (this.health.z < this.health.x) this.health.z = this.health.x;
		} else {
			this.shield.z = this.shield.z - damage;

			if (this.shield.z < this.shield.x) {
				float currentShield = this.shield.z;
				this.shield.z = this.shield.x;
				this.damageReceived((int)abs(abs(currentShield) - abs(this.shield.x)));
			}
		}
	}
}

abstract class CDoomCharacter {
	CDoomStadistics stats;
	boolean isVisible;
	PVector pos, spawnpoint;

	CDoomCharacter(float x, float y, float z) {
		this.pos = new PVector(x, y, z);
		this.spawnpoint = new PVector(x, y, z);
		this.isVisible = true;
	}

	float x() { return this.pos.x; }
	float y() { return this.pos.y; }
	float z() { return this.pos.z; }

	void setx(float x) { this.pos.x = x; }
	void sety(float y) { this.pos.y = y; }
	void setz(float z) { this.pos.z = z; }

	void setStats(CDoomStadistics stats) {
		this.stats = stats;
	}

	void setVisible(boolean isVisible) {
		this.isVisible = isVisible;
	}

	void doDamage(CDoomCharacter character) {
		character.damageReceived(this.stats.damage);
	}

	void damageReceived(int damage) {
		this.stats.damageReceived(damage);
	}

	void reset() {
		this.pos = new PVector(spawnpoint.x, spawnpoint.y, spawnpoint.z);
		this.spawnpoint = new PVector(pos.x, pos.y, pos.z);
		this.isVisible = true;
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

	CDoomSlayerStatus status;
	boolean spriteFinished, isMoving;
	CDoomTimer timerShotgun;

  PeasyCam camera;
  float[][] prevColumn;
	float angle;

	CDoomSlayer(float x, float y, float z, camdoom papplet) {
		super(x, y, z);
		this.papplet = papplet;
		this.reset();
	}

	void reset() {
		super.reset();
		this.prevPos = new PVector(pos.x, pos.y, pos.z);
		this.status = CDoomSlayerStatus.SLAYER_NORMAL;

		this.setStats(new CDoomStadistics(
			CDOOM_MIN_HEALTH, CDOOM_MAX_HEALTH_SLAYER,
			CDOOM_MIN_SHIELD, CDOOM_MAX_SHIELD,
			CDOOM_DAMAGE_SLAYER
		));

		this.prevPos = new PVector(pos.x, pos.y, pos.z);
		this.bounce = new PVector(0, 0);
		this.bounceDirection = new boolean[2];

		this.spriteFinished = true;
		this.timerShotgun = new CDoomTimer();

		this.camera = new PeasyCam(this.papplet, pos.x, pos.y, pos.z, 50);
    this.camera.setDistance(50);
    this.camera.setActive(false);
		this.camera.setWheelHandler(null);

		this.prevColumn = new float[3][6];

    for(int i = 0; i < this.prevColumn.length; i++) {
      this.prevColumn[0][i] = pos.x;
      this.prevColumn[1][i] = pos.y;
      this.prevColumn[2][i] = pos.z;
    }

    rotate(180);
		restorePosition();
	}

	void bouncing() {
		if (!this.isMoving) {
			this.bounce = new PVector(0, 0);
			this.bounceDirection = new boolean[2];
			return;
		}

		bounce.x += bounceDirection[0]? 0.1 : -0.1;
		if (bounce.x > 8 || bounce.x < 0)
			bounceDirection[0] = !bounceDirection[0];

		bounce.y += bounceDirection[1]? 0.1 : -0.1;
		if (bounce.y > 4 || bounce.y < 0)
			bounceDirection[1] = !bounceDirection[1];
	}

	void damageReceived(int damage) {
		super.damageReceived(damage);
		this.status = CDoomSlayerStatus.SLAYER_PAIN;
	}

	void display() {
		if (this.isVisible) {
			displaySlayerGU(); camera.beginHUD();
			float w = shotgun.width, h = shotgun.height;

			switch(this.status) {
				case SLAYER_NORMAL:
					image(shotgun, (width - w) / 2 - 40 + bounce.x, height - h + bounce.y, w, h);
					this.bouncing();
				break;

				case SLAYER_ATTACK:
					this.timerShotgun.run();

					if (this.timerShotgun.hasFinished) {
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
							this.status = CDoomSlayerStatus.SLAYER_NORMAL;
							this.spriteFinished = true;
							this.timerShotgun.setTime(6);
						}
					} else {
						image(shotgun, (width - w) / 2 - 40 + bounce.x, height - h + bounce.y, w, h);
						this.bouncing();
					}
				break;

				case SLAYER_PAIN:
					image(shotgun, (width - w) / 2 - 40 + bounce.x, height - h + bounce.y, w, h);
					this.bouncing();

					if (this.stats.health.z > 0) {
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
	}

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

  void rotate(float angle) {
    camera.rotateY(radians(angle));
    this.angle += angle;

    if (this.angle > 360 || this.angle < -360) {
			float value = this.angle < 0 ? 1 : -1;
      this.angle = round(this.angle / 360) + value;
    }
  }

  void move() {
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
		this.reset();
	}

	void reset() {
		super.reset();
		this.time = 0;
		this.shoot = true;

		this.setStats(new CDoomStadistics(
			CDOOM_MIN_HEALTH, CDOOM_MAX_HEALTH_ENEMY,
			CDOOM_DAMAGE_ENEMY
		));
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
