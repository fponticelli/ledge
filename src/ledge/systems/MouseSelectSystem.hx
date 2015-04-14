package ledge.systems;

import pixi.core.display.Container;
import edge.pixi.components.Position;
import edge.Entity;
import ledge.components.Selectable;
import ledge.components.Selected;

class MouseSelectSystem implements edge.ISystem extends edge.pixi.cosystems.MouseSystem {
  var selected : Selected;
  var entity : Entity;
  public function new(stage : Container, selected : Selected) {
    super(stage);
    this.selected = selected;
  }

  function update(selectable : Selectable, position : Position) {
    if(!firstDown)
      return;
    var dx = x - position.x,
        dy = y - position.y;
    if(selectable.radius * selectable.radius < dx * dx + dy * dy)
      return;
    if(null != selected.entity)
      selected.entity.remove(selected);
    selected.entity = entity;
    entity.add(selected);
  }
}
