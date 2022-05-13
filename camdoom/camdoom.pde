import java.util.List;
import java.util.ArrayList;

CDoomGame game;

void setup() {
	size(800, 800, P3D);

	CDoomMap map = new CDoomMap("e1m1");
	CDoomHeroe heroe = new CDoomHeroe(10, 10, 10);
	game = new CDoomGame(map, heroe);
}

void draw() {
	background(0);
	game.display();
}
