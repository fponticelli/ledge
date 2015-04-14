package ledge;

import edge.Engine;
import edge.Phase;
import edge.World;
import pixi.core.display.Container;
import pixi.core.renderers.SystemRenderer;
import edge.pixi.components.*;
import edge.pixi.systems.*;

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
    var p = engine.create([
        edge.pixi.components.DisplaySprite.fromImagePath("assets/player.png")
      ]);
  }

  public function addSystems() {
    // interaction

    // physics
    physics.add(new UpdatePositionVelocity());
    physics.add(new UpdateRotationVelocity());

    // rendering systems
    render.add(new UpdatePosition());
    render.add(new UpdateRotation());
    render.add(renderer);
  }
}
