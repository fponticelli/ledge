package ledge.systems;

import ledge.components.Selectable;
import ledge.components.Selected;
import ledge.components.Structure;
import pixi.core.graphics.Graphics;
import pixi.core.display.Container;

class RenderSelected implements edge.ISystem {
  var g : Graphics;
  var r : Float;
  public function new(stage : Container) {
    g = new Graphics();
    stage.addChild(g);
    r = 0;
  }

  function update(selected : Selected, selectable : Selectable, structure : Structure) {
    if(selectable.radius != r) {
      r = selectable.radius;
      g.clear();
      g.lineStyle(4, 0x993300, 0.8);
      g.beginFill(0xFF6633, 0.5);
      g.drawCircle(0, 0, r);
      g.endFill();
    }
    g.position.set(structure.body.position.x, structure.body.position.y);
  }
}
