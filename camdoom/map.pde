// map.pde
//
// This file includes the implementation to build
// a CamDoom map with shapes and shaders.
//

/**
 * CDoomRoom
 *
 * A room at CamDoom is an area composed by 3D models
 * which are enemies, items, or just the main hall.
 */
class CDoomRoom {
	PShape model;
	List<CDoomShape> items;
	List<CDoomCharacter> enemies;

	/**
	 * Creates a new room
	 */
	CDoomRoom(String modelPath) {
		this.items = new ArrayList<CDoomShape>();
		this.enemies = new ArrayList<CDoomCharacter>();
		this.model = loadShape(modelPath);
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

	/**
	 * Display current room
	 */
	void display() {
		shape(model);

		for (int i = 0; i < items.size(); i++) {
			CDoomShape item = items.get(i);
			item.display();
		}

		for (int i = 0; i < enemies.size(); i++) {
			CDoomCharacter enemy = enemies.get(i);
			enemy.display();
		}
	}
}

// Defines the level for next map that would
// be created at CamDoom game
int lastLevel = 0;

/**
 * CDoomMap
 *
 * A CamDoom map is defined as a list of rooms which are all invisible
 * for current player except one of them. The position of the heroe would
 * be the main factor that affects the room that will be visible.
 */
class CDoomMap {
	List<CDoomRoom> rooms;
	final String name;
	final int level;
	int roomSelected;

	/**
	 * Create a new map with a name
	 */
	CDoomMap(String name) {
		this.rooms = new ArrayList<CDoomRoom>();
		this.level = lastLevel++;
		this.roomSelected = 0;
		this.name = name;
	}

	/**
	 * Set the visible room
	 */
	void setRoom(int roomSelected) {
		if (roomSelected >= 0 && roomSelected < rooms.size()) {
			this.roomSelected = roomSelected;
		}
	}

	/**
	 * Add a new room
	 */
	void add(CDoomRoom room) {
		this.rooms.add(room);
	}

	/**
	 * Display current map
	 */
	void display() {
		if (roomSelected >= 0 && roomSelected < this.rooms.size()) {
			this.rooms.get(roomSelected).display();
		}
	}
}
