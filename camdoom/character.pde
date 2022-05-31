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
	PVector bounce;
	boolean[] bounceDirection;
  float time;
  boolean shoot;

	CDoomSlayerStatus status;
	boolean spriteFinished, isMoving, noEnemy;
	CDoomTimer timerShotgun;

  PeasyCam camera;
	float angle;

	ImageCDoomAnimation shotgunShoot;
	CDoomSprite bloodEffect, shotgun;

	CDoomSlayer(float x, float y, float z, camdoom papplet) {
		super(x, y, z);
		this.papplet = papplet;
		this.reset();
	}

	void reset() {
		super.reset();

		this.status = CDoomSlayerStatus.SLAYER_NORMAL;
		this.isMoving = false;
		this.noEnemy = true;

		this.setStats(new CDoomStadistics(
			CDOOM_MIN_HEALTH, CDOOM_MAX_HEALTH_SLAYER,
			CDOOM_MIN_SHIELD, CDOOM_MAX_SHIELD,
			CDOOM_DAMAGE_SLAYER
		));

		PImage tempShotgun = loadImage(CDOOM_SHOTGUN);
		this.shotgun = new CDoomSprite(
			CDOOM_SHOTGUN, tempShotgun.width * 3,
			tempShotgun.height * 3
		);

		this.bloodEffect = new CDoomSprite(
			CDOOM_BLOOD_EFFECT,
			width, height
		);

		this.shotgunShoot = new ImageCDoomAnimation(
			CDOOM_SHOTGUN_PREPARING,
			shotgun.dim.x, shotgun.dim.y, 3
		);

		this.bounce = new PVector(0, 0);
		this.bounceDirection = new boolean[2];

		this.spriteFinished = true;
		this.timerShotgun = new CDoomTimer();

		this.camera = new PeasyCam(this.papplet, pos.x, pos.y, pos.z, 50);
    this.camera.setActive(false);
		this.camera.setWheelHandler(null);

		this.startingPosition();
    this.rotate(180);
	}

	void bouncing() {
		if (!this.isMoving) {
			this.bounce = new PVector(0, 0);
			this.bounceDirection = new boolean[2];
			return;
		}

		bounce.x += bounceDirection[0]? 0.3 : -0.3;
		if (bounce.x > 10 || bounce.x < 0)
			bounceDirection[0] = !bounceDirection[0];

		bounce.y += bounceDirection[1]? 0.3 : -0.3;
		if (bounce.y > 4 || bounce.y < 0)
			bounceDirection[1] = !bounceDirection[1];
	}

	void doDamage(CDoomCharacter character) {
		super.doDamage(character);
		this.noEnemy = false;
		displaySlayerGU();
	}

	void damageReceived(int damage) {
		super.damageReceived(damage);
		this.status = CDoomSlayerStatus.SLAYER_PAIN;
	}

	void display() {
		if (this.isVisible) {
			displaySlayerGU(); camera.beginHUD();
			float w = shotgun.dim.x, h = shotgun.dim.y;

			switch(this.status) {
				case SLAYER_NORMAL:
					shotgun.pos.x = (width - w) / 2 - 40 + bounce.x;
					shotgun.pos.y = height - h + bounce.y;
					shotgun.display();
					this.bouncing();
				break;

				case SLAYER_ATTACK:
					this.timerShotgun.run();

					if (this.timerShotgun.hasFinished) {
						// Prepare Sprite
						if (this.spriteFinished) {
							shotgunShoot.setLocation((width - w) / 2 - 40 + bounce.x, height - h + bounce.y);
							shotgunShoot.setPlaying(true);
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
							this.timerShotgun.setTime(5);
						}
					} else {
						shotgun.pos.x = (width - w) / 2 - 40 + bounce.x;
						shotgun.pos.y = height - h + bounce.y;
						shotgun.display();
						this.bouncing();
					}
				break;

				case SLAYER_PAIN:
					shotgun.pos.x = (width - w) / 2 - 40 + bounce.x;
					shotgun.pos.y = height - h + bounce.y;
					shotgun.display();
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

	boolean aiming(float cx, float cy) {
		float c1 = sin(radians(this.angle)) * 400;
		float c2 = sqrt((400*400) - (c1 * c1));

		boolean cond1 = (abs(this.angle) > 90 && abs(this.angle) <= 180);
		boolean cond2 = (abs(this.angle) > 180 && abs(this.angle) <= 270);
		float rangeX, rangeZ;

		if (cond1 || cond2) {
			rangeX = camera.getLookAt()[0] - c1;
			rangeZ = camera.getLookAt()[2] + c2;
		}else {
			rangeX = camera.getLookAt()[0] - c1;
			rangeZ = camera.getLookAt()[2] - c2;
		}

		boolean inside1 = pointCircle(camera.getLookAt()[0], camera.getLookAt()[2], cx, cy, 50);
		boolean inside2 = pointCircle(rangeX, rangeZ, cx, cy, 50);
		if (inside1 || inside2) return true;

		float distX = camera.getLookAt()[0] - rangeX;
		float distY = camera.getLookAt()[2] - rangeZ;
		float len = sqrt( (distX*distX) + (distY*distY) );

		float dot = (((cx-camera.getLookAt()[0])*(rangeX-camera.getLookAt()[0])) + ((cy-camera.getLookAt()[2])*(rangeZ-camera.getLookAt()[2]))) / pow(len,2);

		float closestX = camera.getLookAt()[0] + (dot * (rangeX-camera.getLookAt()[0]));
		float closestY = camera.getLookAt()[2] + (dot * (rangeZ-camera.getLookAt()[2]));

		boolean onSegment = linePoint(camera.getLookAt()[0],camera.getLookAt()[2],rangeX,rangeZ, closestX,closestY);
		if (!onSegment) return false;

		distX = closestX - cx;
		distY = closestY - cy;
		return sqrt((distX*distX) + (distY*distY)) <= 50;
	}

	boolean pointCircle(float px, float py, float cx, float cy, float r) {
		float distX = px - cx;
		float distY = py - cy;
		float distance = sqrt( (distX*distX) + (distY*distY) );

		return distance <= r;
	}

	boolean linePoint(float x1, float y1, float x2, float y2, float px, float py) {
		float d1 = dist(px,py, x1,y1);
		float d2 = dist(px,py, x2,y2);

		float lineLen = dist(x1,y1, x2,y2);
		float buffer = 0.1;

		return d1+d2 >= lineLen-buffer && d1+d2 <= lineLen+buffer;
	}

  void restorePosition() {
    camera.backward(2);
  }

  void startingPosition() {
		if (this.camera != null) {
			this.camera.reset(1000);
	    this.camera.lookAt(pos.x,pos.y,pos.z,500);
		}
  }

  float getCurretX() {
    return camera.getLookAt()[0];
  }

  float getCurretY() {
    return camera.getLookAt()[1];
  }

  float getCurretZ() {
    return camera.getLookAt()[2];
  }

  void moveY(float newY){
    camera.move(0,newY,0);
  }

  void rotate(float angle) {
    camera.rotateY(radians(angle));
    this.angle += angle;

    if (this.angle > 360 || this.angle < -360) {
			float value = this.angle < 0 ? 1 : -1;
      this.angle = round(this.angle / 360) + value;
    }
  }

  void move(boolean direction) {
		if (direction == true) this.camera.forward(2);
		else this.camera.backward(2);
  }
}

// -----------------------------
// Enemy
// -----------------------------

class CDoomEnemy extends CDoomCharacter {
	float time;
  boolean shoot;
	CDoomTimer timer;
	ModelCDoomAnimation enemyWalk, enemyAttack, enemyDie;
	float angle;

	CDoomEnemy(float x, float y, float z) {
		super(x, y, z);
		this.reset();
	}

	void reset() {
		super.reset();
		this.time = 0;
		this.shoot = true;
		this.timer = new CDoomTimer();

		this.setStats(new CDoomStadistics(
			CDOOM_MIN_HEALTH, CDOOM_MAX_HEALTH_ENEMY,
			CDOOM_DAMAGE_ENEMY
		));

		this.enemyWalk = new ModelCDoomAnimation(
			CDOOM_ENEMY_WALK, new ImageCDoomShape(pos.x, pos.y, pos.z, 50, 50), 4
		);

		this.enemyAttack = new ModelCDoomAnimation(
			CDOOM_ENEMY_ATTACK, new ImageCDoomShape(pos.x, pos.y, pos.z, 50, 50), 10
		);

		this.enemyDie = new ModelCDoomAnimation(
			CDOOM_ENEMY_DIE, new ImageCDoomShape(pos.x, pos.y, pos.z, 50, 50), 10
		);

		this.angle = slayer.angle;
	}

	void doDamage(CDoomCharacter character) {
		super.doDamage(character);
	}

	void damageReceived(int damage) {
		super.damageReceived(damage);
		enemyPainSound.play();
		slayer.noEnemy = false;
		displaySlayerGU();

		if (this.stats.health.z <= this.stats.health.x) {
			enemyPainSound.stop();
			enemyDeathSound.play();
			this.enemyDie.setPlaying(true);
			this.setVisible(false);
		}
	}

	boolean inRange(float px, float pz) {
		float distX = px - this.x(), distZ = pz - this.z();
		float distance = sqrt((distX * distX) + (distZ * distZ));
		return distance <= 250;
	}

	void display() {
		if (this.isVisible) {
			this.enemyWalk.model.x = this.pos.x;
			this.enemyWalk.model.y = this.pos.y;
			this.enemyWalk.model.z = this.pos.z;

			this.enemyAttack.model.x = this.pos.x;
			this.enemyAttack.model.y = this.pos.y;
			this.enemyAttack.model.z = this.pos.z;
			this.timer.run();

			if (!this.enemyAttack.isPlaying)
				if (!this.enemyWalk.isPlaying)
					this.enemyWalk.setPlaying(true);

			this.enemyAttack.play();
			this.enemyWalk.play();

			if (this.timer.hasFinished) {
				if (!enemyNormalSound.isPlaying()) {
          enemyNormalSound.play();
          this.timer.setTime(55);
        }
			}
		} else {
			this.enemyDie.play();
		}
	}
}
