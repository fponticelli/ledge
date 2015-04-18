package ledge.systems;

import pixi.core.display.Container;
import edge.Entity;
import edge.pixi.components.Display;
import ledge.components.Button;

class MouseButtonSystem implements edge.ISystem extends edge.pixi.cosystems.MouseSystem {
  public function new(stage : Container)
    super(stage);

  function update(display : Display, button : Button) {
    if(!firstDown)
      return false;
    var x1 = display.node.x - button.width / 2,
        x2 = display.node.x + button.width / 2,
        y1 = display.node.y - button.height / 2,
        y2 = display.node.y + button.height / 2;
    if(x < x1 || x > x2 || y < y1 || y > y2)
      return true;
    button.handler();
    return false;
  }
}
