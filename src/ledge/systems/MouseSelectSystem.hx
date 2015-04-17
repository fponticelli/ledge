package ledge.systems;

import pixi.core.display.Container;
import edge.Entity;
import ledge.components.Structure;
import ledge.components.Selectable;
import ledge.components.Selected;

class MouseSelectSystem implements edge.ISystem extends edge.pixi.cosystems.MouseSystem {
  var selected : Selected;
  var entity : Entity;
  public function new(stage : Container, selected : Selected) {
    super(stage);
    this.selected = selected;
  }

  function update(selectable : Selectable, structure : Structure) {
    if(!firstDown)
      return false;
    var dx = x - structure.body.position.x,
        dy = y - structure.body.position.y;
    if(selectable.radius * selectable.radius < dx * dx + dy * dy)
      return true;
    if(null != selected.entity)
      selected.entity.remove(selected);
    selected.entity = entity;
    entity.add(selected);
    return false;
  }
}
