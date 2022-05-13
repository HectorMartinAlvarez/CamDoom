abstract class CDoomCharacter {
	float x, y, z;
	boolean isVisible;

	CDoomCharacter(float x, float y, float z) {
		this.x = x; this.y = y; this.z = z;
		this.isVisible = true;
	}

	/**
	 * Set the visible state of current character
	 */
	void setVisible(boolean isVisible) {
		this.isVisible = isVisible;
	}

	/**
	 * Move current character whether there's no collisions
	 */
	void move(float incrX, float incrY, float incrZ) {
		this.x = this.x + incrX;
		this.y = this.y + incrY;
		this.z = this.z + incrZ;
	}

	/**
	 * Display the character
	 */
	abstract void display();
}

class CDoomHeroe extends CDoomCharacter {
	CDoomHeroe(float x, float y, float z) {
		super(x, y, z);

		// More stuff here ...
		// but not for now
	}

	void display() {
		if (this.isVisible) {
			// ...
		}
	}
}

class CDoomEnemy extends CDoomCharacter {
	CDoomEnemy(float x, float y, float z) {
		super(x, y, z);

		// More stuff here ...
		// but not for now
	}

	void display() {
		if (this.isVisible) {
			// ...
			// not for now
		}
	}
}
