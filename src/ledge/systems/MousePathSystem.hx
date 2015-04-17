package ledge.systems;

import ledge.components.Selected;
import ledge.components.Waypoints;
import pixi.core.display.Container;
import pixi.core.math.Point;
import edge.Entity;

class MousePathSystem implements edge.ISystem extends edge.pixi.cosystems.MouseSystem {
  public function new(stage : Container)
    super(stage);

  function update(waypoints : Waypoints, selected : Selected) {
    if(!firstDown)
      return;
    waypoints.path.push(new Point(x, y));
  }
}
