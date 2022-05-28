import peasy.*;

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
	 * Display the character
	 */
	abstract void display();
}

class CDoomSlayer extends CDoomCharacter {
  PeasyCam camera;
  float angle;
  float previousX;
  float previousY;
  float previousZ;
  float[] previousColumnX = new float[6];
  float[] previousColumnY = new float[6];
  float[] previousColumnZ = new float[6];

	CDoomSlayer(float x, float y, float z,camdoom t) {
		super(x, y, z);
		camera = new PeasyCam(t, x, y, z, 50);  
    camera.setDistance(50);
    camera.setActive(false);
    previousX = x;
    previousY = y;
    previousZ = z;
    for(int i = 0; i < previousColumnX.length; i++){
      previousColumnX[i] = x;
      previousColumnY[i] = y;
      previousColumnZ[i] = z;
    }
    rotateCamera(180);
		restorePosition();
	}

	void display() {
	}

  void restorePosition(){
    camera.lookAt(previousX, previousY, previousZ);
  }

  void savePosition(){
    float[] pos = camera.getLookAt();
    previousX = pos[0];
    previousY = pos[1];
    previousZ = pos[2];
  }

  void restoreColumnsPosition(int index){
    camera.lookAt(previousColumnX[index], previousColumnY[index], previousColumnZ[index]);  
  }
  
  void saveColumnsPosition(int index){
    float[] pos = camera.getLookAt();
    previousColumnX[index] = pos[0];
    previousColumnY[index] = pos[1];
    previousColumnZ[index] = pos[2];
  }
  
  void rotateCamera(float angle){
    camera.rotateY(radians(angle));
    this.angle += angle;
    if(this.angle > 360){
      this.angle = round(this.angle/360);
    }
  }
  
  void drawHUD(){
    camera.beginHUD();
    text("TEST", 50,50);
    camera.endHUD();
  }
  
  void setYAxis(float y){
   this.y = y;
  }
  
  void moveSlayer(){
    
    float c1 = sin(radians(this.angle))*5;
    float c2 = sqrt((25)-(c1*c1));
    
    if(this.angle <= 90){
      this.x-=c1;
      this.z-=c2;
    }else if(this.angle > 90 && this.angle <= 180){
      this.x-=c1;
      this.z+=c2;
    }else if(this.angle > 180 && this.angle <= 270){
      this.x-=c1;
      this.z+=c2;
    }else {
      this.x-=c1;
      this.z-=c2;
    }
    camera.lookAt(this.x,this.y,this.z);  
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
