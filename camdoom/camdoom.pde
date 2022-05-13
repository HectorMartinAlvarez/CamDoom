CubeCDoomShape cube;

void setup() {
	size(800, 800, P3D);
	cube = new CubeCDoomShape(width / 2, height / 2, 10, 100);
}

void draw() {
	background(0);

  	fill(255);
  	rotate(radians(30));
	cube.display();
}
