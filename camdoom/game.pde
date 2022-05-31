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

class CDoomGame {
	CDoomSlayer slayer;
	CDoomMap map;
  CDoomStairs stairs;
  CDoomColumns[] columns;
  Face face;
  boolean reDoCollision;

	CDoomGame(CDoomMap map, CDoomSlayer slayer, CDoomStairs stairs, CDoomColumns[] columns, Face face) {
    this.slayer = slayer;
    this.map = map;
    this.stairs = stairs;
    this.columns = columns.clone();
		this.reDoCollision = true;
    this.face = face;
    slayer.camera.lookAt(slayer.getCurretX(),slayer.getCurretY(),slayer.getCurretZ(),1000);
  }

	void reset() {
		this.map.reset();
		this.slayer.reset();
		this.reDoCollision = true;
	}

	void update() {
		checkSlayerDamage();
    if(!map.mapCollisions(slayer.getCurretX(), slayer.getCurretZ())) slayer.restorePosition();

    for (int i = 0; i < stairs.stairs.length;i++) {
      if (stairs.stairsCollisions(stairs.stairs[i], slayer.getCurretX(), slayer.getCurretZ())) {
        if(round(slayer.getCurretY()) != stairs.stairs[i].get(0).y){
          slayer.moveY((abs(slayer.getCurretY()) - abs(stairs.stairs[i].get(0).y)));
        }

        if (slayer.getCurretZ() > 835 && reDoCollision) {
					reDoCollision = false;

					for (int j = 0, k = map.vertexes.length - 1; j < 5; j++, k--) {
          	map.vertexes[j] = new PVector(188.5, 0, 835.8);
          	map.vertexes[k] = new PVector(-60.8, 0, 835.9);
         	}
        }
      }
    }

		// Check items
		for (CDoomItem item : map.items) {
			if (item.isVisible == true) {
				if (item instanceof MedicalKitCDoomItem) {
					MedicalKitCDoomItem medKit = (MedicalKitCDoomItem) item;
					medKit.display();
					if(medKit.pickUpItem()) medKit.apply();
				} else if (item instanceof BulletproofVestCDoomItem) {
					BulletproofVestCDoomItem vest = (BulletproofVestCDoomItem) item;
					vest.display();
					if(vest.pickUpItem()) vest.apply();
				}
			}
		}

    if (map.mapEnd(slayer.getCurretX(),slayer.getCurretZ())) {
			game.reset();
      gameState = 1;
    }

  }

  void updatedColumn() {
    for(int i = 0; i < columns.length; i++) {
			boolean cond = columns[i].mapCollisions(slayer.getCurretX(), slayer.getCurretZ());
      if(cond) slayer.restorePosition();
    }
  }

	void checkSlayerDamage() {
		slayer.noEnemy = true;

		for (int i = 0; i < this.map.enemies.size(); i++) {
			CDoomEnemy enemy = this.map.enemies.get(i);

			if (enemy.shoot && enemy.isVisible) {
				if (slayer.aiming(enemy.x(), enemy.z()) && enemy.isVisible) {
					slayer.noEnemy = false;
				}

				if (enemy.inRange(slayer.getCurretX(), slayer.getCurretZ())) {
					if (!confirmSound.isPlaying()) {
						confirmSound.play();
					}

					this.slayer.damageReceived(enemy.stats.damage);
					enemy.shoot = false;
					enemy.time = millis() + 4000;
				}
			} else if ((enemy.time - millis()) < 0) {
				enemy.shoot = true;

				if (!enemy.enemyAttack.isPlaying) {
					enemy.enemyAttack.setPlaying(true);
					enemy.enemyWalk.setPlaying(false);
				}
			}
		}
  }

  void slayerActions() {
    if (preJaw == 0) preJaw = 20;
    if (face.found > 0) {
      if (this.face.posePosition.x > 0 && this.face.posePosition.x < 250) slayer.rotate(0.8);
      if (this.face.posePosition.x > 450) slayer.rotate(-0.8);
      if (this.face.jaw > preJaw + 3) slayer.move(true);

      for (CDoomEnemy enemy : map.enemies) {
        if (this.face.eyebrowLeft > 8 && this.face.eyebrowRight > 8 && slayer.shoot) {
          slayer.status = CDoomSlayerStatus.SLAYER_ATTACK;

          if (slayer.aiming(enemy.x(), enemy.z()) && enemy.isVisible) {
            enemy.damageReceived(40);
            slayer.shoot = false;
            slayer.time = millis() + 100;
          }
        } else if ((enemy.time - millis()) < 0) {
          slayer.shoot = true;
        }
      }
    } else {
    	slayer.camera.beginHUD();
     	pushStyle();
     	textSize(50);
     	textAlign(CENTER);
     	stroke(255, 255, 255);
     	text("No Face Detected", width / 2, height / 2);
     	popStyle();
     	slayer.camera.endHUD();
    }
  }

	void display() {
  	if (DEV_MODE) {
			float x = slayer.camera.getLookAt()[0];
			float y = slayer.camera.getLookAt()[1];
			float z = slayer.camera.getLookAt()[2];
			println("Position: " + x, y, z);
		}

		this.map.display();
		this.slayer.display();
		this.update();
  	this.updatedColumn();
    slayerActions();
	}
}
