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
import nape.shape.*;

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
            new Circle(12, new nape.geom.Vec2(0, -20)),
            new Circle(12, new nape.geom.Vec2(0, 20)),
            new Circle(16)
          ],
          new nape.phys.Material(0.8, 1.0, 1.4, 1.5, 0.01)
          );
    head.body.position.setxy(x, y);
    var p = engine.create([
        head,
        new Selectable(40),
        new Waypoints()
      ]);
  }

  function createButton(x : Float, y : Float, label : String, handler : Void -> Void) {
    var text = new pixi.core.text.Text(label),
        bg = new pixi.core.graphics.Graphics(),
        container = new pixi.core.display.Container(),
        w = 120,
        h = 30;
    bg.beginFill(0x367890, 0.75);
    bg.drawRoundedRect(-w/2,-h/2, w, h, 5);
    container.addChild(bg);
    container.addChild(text);
    text.anchor.set(0.5, 0.5);
    container.x = x;
    container.y = y;
    return engine.create([
        new Display(container),
        new Button(handler, w, h)
      ]);
  }

  public function addEnitities() {
    createWarrior(100, 100);
    createWarrior(500, 200);
    createWarrior(300, 500);

    createButton(
      720, 30,
      "click me",
      function() trace("CLICK")
    );
  }

  public function addSystems() {
    // interaction
    var mouse = frame.createPhase();
    mouse.add(new MouseButtonSystem(stage));
    mouse.add(new MouseSelectSystem(stage, Selected.instance));
    mouse.add(new MousePathSystem(stage));

    // physics
    var realtime = physics.createPhase();
    realtime.add(new PhysicsSpace());

    // rendering systems
    render.add(new RenderWaypoints(stage));
    render.add(new RenderSelected(stage));
    render.add(new PhysicsDisplayUpdate());
    render.add(new PhysicsDebugRenderer(stage));
    render.add(renderer);
  }
}
