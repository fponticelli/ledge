package ledge.components;

import edge.Entity;
import pixi.core.math.Point;

class Waypoints implements edge.IComponent {
  var path : Array<Point>;
	public function new() {
    path = [];
  }
}
