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

class CDoomStairs {
	final ArrayList<PVector>[] stairs;

	CDoomStairs(String collisionPath) {
		this.stairs = new ArrayList[17];
		Table tabStairs = loadTable(collisionPath);

		for (int i=0, j = 0; i < 17; i++) {
			stairs[i] = new ArrayList<PVector>();
			float x, y, z;

      while(j < tabStairs.getRowCount() - 1 && tabStairs.getFloat(j, 1) == tabStairs.getFloat(j + 1, 1)) {
				x = tabStairs.getFloat(j, 0);
				y = tabStairs.getFloat(j, 1);
				z = tabStairs.getFloat(j++, 2);
				stairs[i].add(new PVector(x, y, z));
      }

			x = tabStairs.getFloat(j, 0);
			y = tabStairs.getFloat(j, 1);
			z = tabStairs.getFloat(j++, 2);
      stairs[i].add(new PVector(x, y, z));
    }
	}

  boolean stairsCollisions(ArrayList<PVector> vertexes, float px, float py) {
    boolean collision = false;
    int next = 0;

    for (int current = 0; current < vertexes.size(); current++) {
      next = current + 1;
      if (next == vertexes.size()) next = 0;

      PVector vc = vertexes.get(current);
      PVector vn = vertexes.get(next);

			boolean cond1 = ((vc.z >= py && vn.z < py) || (vc.z < py && vn.z >= py));
			boolean cond2 = (px < (vn.x-vc.x)*(py-vc.z) / (vn.z-vc.z)+vc.x);
      if (cond1 && cond2) collision = !collision;
    }

    return collision;
  }
}

class CDoomColumns {
  final PVector[] vertexes;

  CDoomColumns(PVector[] columns) {
		this.vertexes = columns.clone();
  }

  boolean mapCollisions(float px, float pz) {
    boolean collision = false;
    int next = 0;

    for (int current = 0; current < vertexes.length; current++) {
			next = current + 1;
      if (next == vertexes.length) next = 0;

      PVector vc = vertexes[current];
      PVector vn = vertexes[next];

			boolean cond1 = ((vc.z >= pz && vn.z < pz) || (vc.z < pz && vn.z >= pz));
			boolean cond2 = (px < (vn.x-vc.x)*(pz-vc.z) / (vn.z-vc.z)+vc.x);
      if (cond1 && cond2) collision = !collision;
    }

    return collision;
  }
}

class CDoomMap {
	final PShape model;
  PVector[] vertexes;
  PVector[] vertexes_end = new PVector[4];
  List<CDoomItem> items;
  List<CDoomEnemy> enemies;

	CDoomMap(String mapPath, String collisionPath) {
    this.items = new ArrayList<CDoomItem>();
    this.enemies = new ArrayList<CDoomEnemy>();
		this.model = loadShape(mapPath);
    loadMapCollision(collisionPath);

    vertexes_end[0] = new PVector(-903.7,0,1102.6);
    vertexes_end[1] = new PVector(-1085.9,0,1093.4);
    vertexes_end[2] = new PVector(-1050.1,0,1183.2);
    vertexes_end[3] = new PVector(-935.1,0,1183.5);
	}

  void loadMapCollision(String collisionPath) {
    Table tableValue = loadTable(collisionPath);
    vertexes = new PVector[tableValue.getRowCount()];

    for (int i=0; i < tableValue.getRowCount(); i++) {
      float x = tableValue.getFloat(i,0), y = 0;
      float z = tableValue.getFloat(i,1);
      vertexes[i] = new PVector(x, y, z);
    }
  }

	void reset() {
		this.loadMapCollision(CDOOM_MAP_COLLISIONS);
		for (CDoomEnemy e : enemies) e.reset();
		for (CDoomItem i : items) i.setVisible(true);
	}

  void addItem(CDoomItem item) {
		this.items.add(item);
  }

  void addEnemy(CDoomEnemy enemy) {
    this.enemies.add(enemy);
  }

  boolean mapCollisions(float px, float py) {
    boolean collision = false;
    int next = 0;

    for (int current = 0; current < vertexes.length; current++) {
      next = current + 1;
      if (next == vertexes.length) next = 0;

      PVector vc = vertexes[current];
      PVector vn = vertexes[next];

			boolean cond1 = ((vc.z >= py && vn.z < py) || (vc.z < py && vn.z >= py));
			boolean cond2 = (px < (vn.x-vc.x)*(py-vc.z) / (vn.z-vc.z)+vc.x);
      if (cond1 && cond2) collision = !collision;
    }

    return collision;
  }

  boolean mapEnd(float px, float py) {
    boolean collision = false;
    int next = 0;

    for (int current = 0; current < vertexes_end.length; current++) {
      next = current + 1;
      if (next == vertexes_end.length) next = 0;

      PVector vc = vertexes_end[current];
      PVector vn = vertexes_end[next];

      boolean cond1 = ((vc.z >= py && vn.z < py) || (vc.z < py && vn.z >= py));
      boolean cond2 = (px < (vn.x-vc.x)*(py-vc.z) / (vn.z-vc.z)+vc.x);
      if (cond1 && cond2) collision = !collision;
    }

    return collision;
  }

	void display() {
		pushMatrix();
		textureWrap(REPEAT);
		lights();
		shape(model, 0, 0);

		textureWrap(CLAMP);
		for (CDoomEnemy e : enemies) e.display();
		for (CDoomItem i : items) i.display();
		popMatrix();
	}
}
