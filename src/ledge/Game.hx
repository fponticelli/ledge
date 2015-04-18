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

  function createWarrior(x : Float, y : Float) {
    var head = new Structure(
          [
            new Circle(20),
            new Circle(12, new nape.geom.Vec2(0, -20)),
            new Circle(12, new nape.geom.Vec2(0, 20))
          ],
          new nape.phys.Material(0.8, 1.0, 1.4, 1.5, 0.01)
          );
    head.body.position.setxy(x, y);
    var p = engine.create([
        head,
        new Selectable(30),
        new Waypoints()
      ]);
  }

  public function addEnitities() {
    createWarrior(100, 100);
    createWarrior(500, 200);
    createWarrior(300, 500);
  }

  public function addSystems() {
    // interaction
    var mouse = frame.createPhase();
    mouse.add(new MouseSelectSystem(stage, Selected.instance));
    mouse.add(new MousePathSystem(stage));

    // physics
    var realtime = physics.createPhase();
    realtime.add(new PhysicsSpace());

    // rendering systems
    render.add(new RenderSelected(stage));
    render.add(new PhysicsDisplayUpdate());
    render.add(new PhysicsDebugRenderer(stage));
    render.add(new RenderWaypoints(stage));
    render.add(renderer);
  }
}
