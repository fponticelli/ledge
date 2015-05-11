package ledge.systems;

import edge.*;
import ledge.components.*;
import nape.geom.Vec2;

class WaypointApplier implements ISystem {
  var timeDelta : Float;
  var elapsedTime : Float;
  var map : Map<Entity, Float>;
  var entity : Entity;

  public function new() {
    elapsedTime = 0;
    map = new Map();
  }

  public function updateAdded(entity : Entity, data: { structure : Structure, waypoints : Waypoints }) {
    map.set(entity, elapsedTime);
  }

  public function updateRemoved(entity : Entity, data: { structure : Structure, waypoints : Waypoints }) {
    map.remove(entity);
  }

  public function before() {
    elapsedTime += timeDelta;
  }

  public function update(structure : Structure, waypoints : Waypoints) {
    var currTime = map.get(entity);

    if (currTime > elapsedTime) return;

    var next = waypoints.path.shift();

    if (next == null) return;

    var vec = new Vec2(next.x, next.y);
    var dir = vec.sub(structure.body.position);
    structure.body.velocity.set(dir);

    map.set(entity, currTime + 1000);
  }
}
