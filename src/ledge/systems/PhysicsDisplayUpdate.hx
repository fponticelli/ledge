package ledge.systems;

import ledge.components.Structure;
import edge.pixi.components.Display;
import edge.Entity;
import edge.ISystem;

class PhysicsDisplayUpdate implements ISystem {
  public function update(structure : Structure, display : Display) {
    var pos = structure.body.position;
    //display.node.pivot.x = display.x;
    //display.node.pivot.y = display.y;
    display.node.rotation = structure.body.rotation;
    display.node.x = pos.x;
    display.node.y = pos.y;
  }
}
