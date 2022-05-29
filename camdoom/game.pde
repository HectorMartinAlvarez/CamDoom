// game.pde
//
// This file includes the implementation of the basic
// engine used to execute CamDoom
//

/**
 * CDoomGame
 *
 * Engine of current CamDoom game.
 */
class CDoomGame {
	CDoomSlayer slayer;
	CDoomMap map;
  CDoomStairs stairs;
  CDoomColumns[] columns = new CDoomColumns[6];
  boolean reDoCollision = true;

	/**
	 * Create a new game
	 */
	CDoomGame(CDoomMap map, CDoomSlayer slayer, CDoomStairs stairs, CDoomColumns[] columns) {
    this.slayer = slayer;
    this.map = map;
    this.stairs = stairs;
    this.columns = columns.clone();
  }

	/**
	 * Update all the contents of current game
	 */
	void update() {
    //slayer.cam.position.y = slayer.previousY;
    slayer.setYAxis(slayer.previousY);
    if(!map.mapCollisions(slayer.camera.getLookAt()[0],slayer.camera.getLookAt()[2])){
      slayer.restorePosition();
    }else{
      slayer.savePosition();
    }
    for(int i = 0; i < stairs.escaleras.length;i++){
      if(stairs.stairsCollisions(stairs.escaleras[i],slayer.camera.getLookAt()[0],slayer.camera.getLookAt()[2])){
        slayer.previousY = stairs.escaleras[i].get(0).y;
        if(/*slayer.cam.position.z*/ slayer.z > 835 && reDoCollision){
          for(int j = 0, k = map.vertices.length-1; j < 5; j++, k--){
           map.vertices[j] = new PVector(188.5,0,835.8);
           map.vertices[k] = new PVector(-60.8,0,835.9); 
         }
         reDoCollision = false;
        }
      }
    }
  }

  void updatedColumn(){
    for(int i = 0; i < columns.length; i++){
      if(!columns[i].mapCollisions(slayer.camera.getLookAt()[0],slayer.camera.getLookAt()[2])){
        slayer.saveColumnsPosition(i);
      }else {
        slayer.restoreColumnsPosition(i);
      }
    }
  }
	
	/*
  *  Check if any enemy should do damage to the Slayer
  */
  void checkSlayerDamage(){
    if(this.enemy1.shoot){
        if(this.enemy1.inRange(slayer.x, slayer.z)){
        this.slayer.doDamage();
        this.enemy1.shoot = false;
        this.enemy1.time = millis() + 4000;
      }
    }else {
      if((this.enemy1.time - millis()) < 0) this.enemy1.shoot = true;
    }
  }

	/**
	 * Display all elements of game
	 */
	void display() {
		map.display();
    this.slayer.drawHUD();
		this.update();
  	this.updatedColumn();
	}
}
