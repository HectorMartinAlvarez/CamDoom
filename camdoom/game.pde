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
  CDoomColumns[] columns = new CDoomColumns[6];
  boolean reDoCollision = true;
	CDoomEnemy enemy1;

	CDoomGame(CDoomMap map, CDoomSlayer slayer, CDoomStairs stairs, CDoomColumns[] columns) {
    this.slayer = slayer;
    this.map = map;
    this.stairs = stairs;
    this.columns = columns.clone();
  }

	void reset() {
		slayer.reset();
	}

	void update() {
		//checkSlayerDamage();
    slayer.setYAxis(slayer.previousY);

    if(!map.mapCollisions(slayer.camera.getLookAt()[0], slayer.camera.getLookAt()[2])) slayer.restorePosition();
    else slayer.savePosition();

    for(int i = 0; i < stairs.stairs.length;i++) {
      if(stairs.stairsCollisions(stairs.stairs[i], slayer.camera.getLookAt()[0], slayer.camera.getLookAt()[2])) {
        slayer.previousY = stairs.stairs[i].get(0).y;

        if(slayer.z > 835 && reDoCollision) {
					reDoCollision = false;

					for(int j = 0, k = map.vertexes.length-1; j < 5; j++, k--) {
          	map.vertexes[j] = new PVector(188.5,0,835.8);
          	map.vertexes[k] = new PVector(-60.8,0,835.9);
         	}
        }
      }
    }
  }

  void updatedColumn() {
    for(int i = 0; i < columns.length; i++) {
			boolean cond = columns[i].mapCollisions(slayer.camera.getLookAt()[0], slayer.camera.getLookAt()[2]);
      if(!cond) slayer.saveColumnsPosition(i);
      else slayer.restoreColumnsPosition(i);
    }
  }

	void checkSlayerDamage() {
    if (this.enemy1.shoot) {
			if (this.enemy1.inRange(slayer.x, slayer.z)) {
				this.slayer.doDamage();
				this.enemy1.shoot = false;
				this.enemy1.time = millis() + 4000;
			}
    } else if ((this.enemy1.time - millis()) < 0)
			this.enemy1.shoot = true;
  }

	void display() {
		map.display();
		this.slayer.display();
		this.update();
  	this.updatedColumn();
	}
}
