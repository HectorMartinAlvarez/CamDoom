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
	CDoomHeroe heroe;
	CDoomMap map;

	/**
	 * Create a new game
	 */
	CDoomGame(CDoomMap map, CDoomHeroe heroe) {
		this.heroe = heroe;
		this.map = map;
	}

	/**
	 * Update all the contents of current game
	 */
	void update() {
		// Check collisions and movement,
		// as well as additional actions
	}

	/**
	 * Display all elements of game
	 */
	void display() {
		map.display();
		heroe.display();
		this.update();
	}
}
