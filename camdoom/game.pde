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
  CDoomColumns column_1;
  CDoomColumns column_2;
  CDoomColumns column_3;
  CDoomColumns column_4;
  CDoomColumns column_5;
  CDoomColumns column_6;

	/**
	 * Create a new game
	 */
	CDoomGame(CDoomMap map, CDoomSlayer slayer, CDoomStairs stairs, CDoomColumns column_1, CDoomColumns column_2,
            CDoomColumns column_3, CDoomColumns column_4, CDoomColumns column_5, CDoomColumns column_6) {
		this.slayer = slayer;
		this.map = map;
    this.stairs = stairs;
    this.column_1 = column_1;
    this.column_2 = column_2;
    this.column_3 = column_3;
    this.column_4 = column_4;
    this.column_5 = column_5;
    this.column_6 = column_6;
	}

	/**
	 * Update all the contents of current game
	 */
	void update() {
    slayer.cam.position.y = slayer.previousY;
		if(!map.mapCollisions(slayer.cam.position.x,slayer.cam.position.z)){
      slayer.restorePosition();
    }else{
      slayer.savePosition();
    }
    for(int i = 0; i < stairs.escaleras.length;i++){
      if(stairs.stairsCollisions(stairs.escaleras[i],slayer.cam.position.x, slayer.cam.position.z)){
        slayer.previousY = stairs.escaleras[i].get(0).y;
        slayer.restorePosition();
        if(i == stairs.escaleras.length-1){
         for(int j = 0, k = map.vertices.length-1; j < 5; j++, k--){
           map.vertices[j] = new PVector(188.5,0,835.8);
           map.vertices[k] = new PVector(-60.8,0,835.9); 
         }
        }
      }
    }
	}

  void updatedColumn(){
    if(!column_1.mapCollisions(slayer.cam.position.x, slayer.cam.position.z)){
      slayer.saveColumn1Position();
    }else {
      slayer.restoreColumn1Position();
    }
    if(!column_2.mapCollisions(slayer.cam.position.x, slayer.cam.position.z)){
      slayer.saveColumn2Position();
    }else {
      slayer.restoreColumn2Position();
    } 
    if(!column_3.mapCollisions(slayer.cam.position.x, slayer.cam.position.z)){
      slayer.saveColumn3Position();
    }else {
      slayer.restoreColumn3Position();
    } 
    if(!column_4.mapCollisions(slayer.cam.position.x, slayer.cam.position.z)){
      slayer.saveColumn4Position();
    }else {
      slayer.restoreColumn4Position();
    } 
    if(!column_5.mapCollisions(slayer.cam.position.x, slayer.cam.position.z)){
      slayer.saveColumn5Position();
    }else {
      slayer.restoreColumn5Position();
    }
    if(!column_6.mapCollisions(slayer.cam.position.x, slayer.cam.position.z)){
      slayer.saveColumn6Position();
    }else {
      slayer.restoreColumn6Position();
    }
  }

	/**
	 * Display all elements of game
	 */
	void display() {
		map.display();
		//slayer.display();
println(slayer.cam.position.x + "|" + slayer.cam.position.z);
		this.update();
    this.updatedColumn();
	}
}
