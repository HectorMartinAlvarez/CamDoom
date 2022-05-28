// map.pde
//
// This file includes the implementation to build
// a CamDoom map with shapes and shaders.
//


class CDoomStairs {
	final ArrayList<PVector>[] escaleras;

	CDoomStairs(String collisionPath) {
		Table esca = loadTable(collisionPath);
    escaleras = new ArrayList[15];
     for (int i=0, j = 0; i < 15; i++) {
       escaleras[i] = new ArrayList<PVector>();
       while(j < esca.getRowCount()-1 && esca.getFloat(j,1) == esca.getFloat(j+1,1)){
         escaleras[i].add(new PVector(esca.getFloat(j,0), esca.getFloat(j,1), esca.getFloat(j,2)));
         j++;
       }
       escaleras[i].add(new PVector(esca.getFloat(j,0), esca.getFloat(j,1), esca.getFloat(j,2)));
       j++;
     }
	}


  boolean stairsCollisions(ArrayList<PVector> vertexes, float px, float py) {
    boolean collision = false;

    int next = 0;
    for (int current=0; current<vertexes.size(); current++) {
      next = current+1;
      if (next == vertexes.size()) next = 0;

      PVector vc = vertexes.get(current);
      PVector vn = vertexes.get(next);

      if (((vc.z >= py && vn.z < py) || (vc.z < py && vn.z >= py)) &&
           (px < (vn.x-vc.x)*(py-vc.z) / (vn.z-vc.z)+vc.x)) {
             collision = !collision;
      }
    }
    return collision;
  }

}

class CDoomColumns {
  final PVector[] vertices;

  CDoomColumns(PVector[] columns) {
    vertices = columns.clone();
  }

  boolean mapCollisions(float px, float pz) {
    boolean collision = false;

    int next = 0;
    for (int current=0; current<vertices.length; current++) {

      next = current+1;
      if (next == vertices.length) next = 0;

      PVector vc = vertices[current];
      PVector vn = vertices[next];

      if (((vc.z >= pz && vn.z < pz) || (vc.z < pz && vn.z >= pz)) &&
           (px < (vn.x-vc.x)*(pz-vc.z) / (vn.z-vc.z)+vc.x)) {
             collision = !collision;
      }
    }
    return collision;
  }

}

/**
 * CDoomMap
 *
 * A CamDoom map is defined as a list of rooms which are all invisible
 * for current player except one of them. The position of the heroe would
 * be the main factor that affects the room that will be visible.
 */
class CDoomMap {
	final PShape model;
  PVector[] vertices;
  List<CDoomShape> items;
  List<CDoomCharacter> enemies;

	/**
	 * Create a new map with a name
	 */
	CDoomMap(String mapPath, String collisionPath) {
    this.items = new ArrayList<CDoomShape>();
    this.enemies = new ArrayList<CDoomCharacter>();
		model = loadShape(mapPath);
    Table tabla = loadTable(collisionPath);
    vertices = new PVector[tabla.getRowCount()];
    for (int i=0; i < tabla.getRowCount(); i++) {
      vertices[i] = new PVector(tabla.getFloat(i,0),0,tabla.getFloat(i,1));
    }
	}

  /**
   * Add a new item
   */
  void addItem(CDoomShape item) {
    this.items.add(item);
  }

  /**
   * Add a new enemy
   */
  void addEnemy(CDoomCharacter enemy) {
    this.enemies.add(enemy);
  }

  boolean mapCollisions(float px, float py) {
    boolean collision = false;

    int next = 0;
    for (int current=0; current<vertices.length; current++) {

      next = current+1;
      if (next == vertices.length) next = 0;

      PVector vc = vertices[current];
      PVector vn = vertices[next];

      if (((vc.z >= py && vn.z < py) || (vc.z < py && vn.z >= py)) &&
           (px < (vn.x-vc.x)*(py-vc.z) / (vn.z-vc.z)+vc.x)) {
             collision = !collision;
      }
    }
    return collision;
  }

	/**
	 * Display current map
	 */
	void display() {
		shape(model, 0, 0);
	}
}
