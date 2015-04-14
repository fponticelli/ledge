package ledge;

import edge.World;
import pixi.core.display.Container;
import pixi.core.renderers.SystemRenderer;
import edge.pixi.components.*;
import edge.pixi.systems.*;

class Game {
	var world : World;
	var stage : Container;
	public function new(renderer : SystemRenderer) {
		world = new World();
		var rendererSystem = new Renderer(renderer);
		stage = rendererSystem.stage;

		// interaction

		// physics
		world.physics.add(new UpdatePositionVelocity());
		world.physics.add(new UpdateRotationVelocity());

		// rendering systems
		world.render.add(new UpdatePosition());
		world.render.add(new UpdateRotation());
		world.render.add(rendererSystem);

		// run
		world.start();
	}
}
