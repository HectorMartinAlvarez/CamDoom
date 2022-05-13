// shape.pde
//
// This file includes all the shapes which would be used
// to build all the objects located at a map, as well as
// the mechanics used to detect collisions
//

/**
 * HasCollisions
 *
 * 	Since objects need to be located at a specific position of current map,
 * 	it is important to check that there are no collisions. This operation needs
 *	to be defined at each shape which is material and could no be transpass
 */
interface HasCollisions {
	/**
	 * Check if passed character has collisions with an object.
	 */
	boolean hasCollisions(CDoomCharacter character);
}

/**
 * DoomShape
 *
 *	CamDoom builds a map using shapes that are located at a specific position and has
 *	defined its own dimensions. This class would define the basic operations that could
 * 	be used to configure a shape, which includes not only its figure, but also the
 *	texture and shaders if it is pleased
 */
abstract class CDoomShape {
	PShape shape;
	PShader shader;
	PImage texture;
	float x, y, z;

	/**
	 * Create a new shape with a specific position.
	 */
	CDoomShape(float x, float y, float z) {
		this.shape = createShape();
		this.x = x; this.y = y; this.z = z;
		this.shader = null;
	}

	/**
	 * Load a texture for current shape
	 */
	void setTexture(String texturePath) {
		if (texturePath != null) {
			this.texture = loadImage(texturePath);
			this.shape.setTexture(this.texture);
		}
	}

	/**
	 * Load current with passed GLSL path
	 */
	void setShader(String shaderPath) {
		if (shaderPath != null) {
			this.shader = loadShader(shaderPath);
		}
	}

	/**
	 * Apply passed property to current shader. This method
	 * would not work whether applyShader has not been configured
	 * and current shader has not been loaded
	 */
	void applyShader(ApplyShader applyShader) {
		if (applyShader != null && this.shader != null) {
			applyShader.apply(this.shader);
		}
	}

	/**
	 * Display current figure
	 */
	void display() {
		pushMatrix();
		translate(this.x, this.y, this.z);

		if (this.shader != null) shader(this.shader);
		shape(this.shape);
		if (this.shader != null) resetShader();

		popMatrix();
	}
}

// _________ Implementation _________

class CubeCDoomShape extends CDoomShape implements HasCollisions {
	float slide;

	CubeCDoomShape(float x, float y, float z, float slide) {
		super(x, y, z);
		this.slide = slide;
    	this.shape = createShape(BOX, this.slide, this.slide, this.slide);
	}

	boolean hasCollisions(CDoomCharacter character) {
		return true;
	}
}
