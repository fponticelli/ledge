package ledge.components;

import edge.Entity;

class Selected implements edge.IComponent {
	var entity : Entity;
	public static var instance(default, null) : Selected = new Selected();
	private function new() { }
}
