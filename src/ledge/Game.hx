package ledge;

import edge.Engine;
import edge.Phase;
import edge.World;
import pixi.core.display.Container;
import pixi.core.renderers.SystemRenderer;
import edge.pixi.components.*;
import ledge.components.*;
import edge.pixi.systems.*;
import ledge.systems.*;

class Game {
  var world : World;
  var engine : Engine;
  var stage : Container;
  var turn : Phase;
  var frame : Phase;
  var physics : Phase;
  var render : Phase;
  var renderer : Renderer;
  public function new(renderer : SystemRenderer) {
    world   = new World();
    engine  = world.engine;
    turn    = engine.createPhase();
    physics = world.physics;
    render  = world.render;
    frame   = world.frame;
    this.renderer = new Renderer(renderer);
    stage   = this.renderer.stage;

    addEnitities();
    addSystems();

    // run
    world.start();
  }

  public function addEnitities() {
		var display = edge.pixi.components.DisplaySprite.fromImagePath("assets/paladin.png");
		display.sprite.scale.set(0.25, 0.25);
    display.sprite.anchor.set(0.5, 0.5);
    var p = engine.create([
        display,
				new Selectable(50),
        new Position(200, 200)
      ]);
  }

  public function addSystems() {
    // interaction
    physics.add(new MouseSelectSystem(stage, Selected.instance));

    // physics
    physics.add(new UpdatePositionVelocity());
    physics.add(new UpdateRotationVelocity());

    // rendering systems
    render.add(new UpdatePosition());
    render.add(new UpdateRotation());
    render.add(new RenderSelected(stage));
    render.add(renderer);
  }
}
