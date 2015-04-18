package ledge.systems;

import ledge.components.Waypoints;
import ledge.components.Selected;
import ledge.components.Structure;
import pixi.core.graphics.Graphics;
import pixi.core.display.Container;

class RenderWaypoints implements edge.ISystem {
  var g : Graphics;
  var r : Float;
  public function new(stage : Container) {
    g = new Graphics();
    stage.addChild(g);
    r = 0;
  }

  function update(selected : Selected, waypoints : Waypoints, structure : Structure) {
    var p1 = { x : structure.body.position.x, y : structure.body.position.y };
    g.clear();
    g.lineStyle(2, 0x993300);
    g.moveTo(p1.x, p1.y);
    for(p2 in waypoints.path) {
      g.lineTo(p2.x, p2.y);
    }
    g.beginFill(0xBB5522);
    for(p2 in waypoints.path) {
      g.drawCircle(p2.x, p2.y, 8);
    }
  }
}
