// shader.pde
//
// This file includes all the configurations that could be done
// at Processing shaders which would be applied to a shape.
//

/**
 * Shaders at Processing could set some properties before calling shader
 * method, since GLSL may require some external information before applying
 * shaders. This interface defines the operation which would be used to configure
 * all the properties of a shader
 */
interface ApplyShader {
	/**
	 * Set new values for each uniform variable defined
	 * at passed Processing shader.
	 */
	void apply(PShader shader);
}

// _________ Implementation _________

class TimeApplyShader implements ApplyShader {
  	float duration;

	TimeApplyShader(float duration) {
		this.duration = duration;
	}

	void apply(PShader shader) {
		shader.set("u_time", this.duration);
	}
}
