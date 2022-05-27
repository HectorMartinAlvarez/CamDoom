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

class CDoomSlayer extends CDoomCharacter {
  QueasyCam cam;
  float previousX;
  float previousY;
  float previousZ;
  float previousColumn1X;
  float previousColumn1Y;
  float previousColumn1Z;
  float previousColumn2X;
  float previousColumn2Y;
  float previousColumn2Z;
  float previousColumn3X;
  float previousColumn3Y;
  float previousColumn3Z;
  float previousColumn4X;
  float previousColumn4Y;
  float previousColumn4Z;
  float previousColumn5X;
  float previousColumn5Y;
  float previousColumn5Z;
  float previousColumn6X;
  float previousColumn6Y;
  float previousColumn6Z;
	CDoomSlayer(float x, float y, float z,QueasyCam newCam) {
		super(x, y, z);
    cam = newCam;
    cam.speed = 0.7;             // default is 3
    cam.sensitivity = 0.2;      // default is 2
    previousX = x;
    previousY = y;
    previousZ = z;
    previousColumn1X = x;
    previousColumn1Y = y;
    previousColumn1Z = z;
    previousColumn2X = x;
    previousColumn2Y = y;
    previousColumn2Z = z;
    previousColumn3X = x;
    previousColumn3Y = y;
    previousColumn3Z = z;
    previousColumn4X = x;
    previousColumn4Y = y;
    previousColumn4Z = z;
    previousColumn5X = x;
    previousColumn5Y = y;
    previousColumn5Z = z;
    previousColumn6X = x;
    previousColumn6Y = y;
    previousColumn6Z = z;
    
		restorePosition();
	}

	void display() {
	}

  void restorePosition(){
    cam.position.x = previousX;
    cam.position.y = previousY;
    cam.position.z = previousZ;
  }
  
  void savePosition(){
    previousX = cam.position.x;
    previousY = cam.position.y;
    previousZ = cam.position.z;
  }
  
  void restoreColumn1Position(){
    cam.position.x = previousColumn1X;
    cam.position.y = previousColumn1Y;
    cam.position.z = previousColumn1Z;
  }
  
  void saveColumn1Position(){
    previousColumn1X = cam.position.x;
    previousColumn1Y = cam.position.y;
    previousColumn1Z = cam.position.z;
  }
  
  void restoreColumn2Position(){
    cam.position.x = previousColumn2X;
    cam.position.y = previousColumn2Y;
    cam.position.z = previousColumn2Z;
  }
  
  void saveColumn2Position(){
    previousColumn2X = cam.position.x;
    previousColumn2Y = cam.position.y;
    previousColumn2Z = cam.position.z;
  }
  
  void restoreColumn3Position(){
    cam.position.x = previousColumn3X;
    cam.position.y = previousColumn3Y;
    cam.position.z = previousColumn3Z;
  }
  
  void saveColumn3Position(){
    previousColumn3X = cam.position.x;
    previousColumn3Y = cam.position.y;
    previousColumn3Z = cam.position.z;
  }
  
  void restoreColumn4Position(){
    cam.position.x = previousColumn4X;
    cam.position.y = previousColumn4Y;
    cam.position.z = previousColumn4Z;
  }
  
  void saveColumn4Position(){
    previousColumn4X = cam.position.x;
    previousColumn4Y = cam.position.y;
    previousColumn4Z = cam.position.z;
  }
  
  void restoreColumn5Position(){
    cam.position.x = previousColumn5X;
    cam.position.y = previousColumn5Y;
    cam.position.z = previousColumn5Z;
  }
  
  void saveColumn5Position(){
    previousColumn5X = cam.position.x;
    previousColumn5Y = cam.position.y;
    previousColumn5Z = cam.position.z;
  }
  
  void restoreColumn6Position(){
    cam.position.x = previousColumn6X;
    cam.position.y = previousColumn6Y;
    cam.position.z = previousColumn6Z;
  }
  
  void saveColumn6Position(){
    previousColumn6X = cam.position.x;
    previousColumn6Y = cam.position.y;
    previousColumn6Z = cam.position.z;
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
