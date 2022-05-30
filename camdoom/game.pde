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
  }

	void reset() {
		this.map.reset();
		this.slayer.reset();
		this.reDoCollision = true;
	}

	void update() {
		checkSlayerDamage();
    slayer.sety(slayer.prevPos.y);

    if(!map.mapCollisions(slayer.x(), slayer.z())) slayer.restorePosition();
    else slayer.savePosition();

    for (int i = 0; i < stairs.stairs.length;i++) {
      if (stairs.stairsCollisions(stairs.stairs[i], slayer.x(), slayer.z())) {
        slayer.prevPos.y = stairs.stairs[i].get(0).y;

        if (slayer.z() > 835 && reDoCollision) {
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
				/*if (round(slayer.x()) == round(item.x()) && round(slayer.z()) == round(item.z())) {
					item.apply();
				}*/
			}
		}
  }

  void updatedColumn() {
    for(int i = 0; i < columns.length; i++) {
			boolean cond = columns[i].mapCollisions(slayer.x(), slayer.z());
      if(!cond) slayer.saveColumnsPosition(i);
      else slayer.restoreColumnsPosition(i);
    }
  }

	void checkSlayerDamage() {
		for (int i = 0; i < this.map.enemies.size(); i++) {
			CDoomEnemy enemy = this.map.enemies.get(i);

			if (enemy.shoot) {
				if (enemy.inRange(slayer.x(), slayer.z())) {
					this.slayer.damageReceived(enemy.stats.damage);
					enemy.shoot = false;
					enemy.time = millis() + 4000;
				}
			} else if ((enemy.time - millis()) < 0) {
				enemy.shoot = true;
			}
		}
  }

  void slayerActions(){
    if(this.face.posePosition.x > 0 && this.face.posePosition.x < 200){
			slayer.rotate(2);
    }
    if(this.face.posePosition.x > 500){
      slayer.rotate(-2);
    }
    if(this.face.jaw > 21){
      slayer.move(true);
    }
    if(this.face.eyebrowLeft > 8 && this.face.eyebrowRight > 8){
      // metodo de disparar
    }
  }

	void display() {
		this.map.display();
		this.slayer.display();
		this.update();
  	this.updatedColumn();
    slayerActions();
	}
}
