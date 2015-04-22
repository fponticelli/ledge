package ledge.components;

import nape.shape.*;
import nape.phys.*;
using thx.Nulls;

class Structure {
  public var shapes : Array<Shape>;
  public var body : Body;

  public function new(shapes : Array<Shape>, material : Material, ?type : BodyType) {
    this.shapes = shapes;
    this.body = new Body(type.or(BodyType.DYNAMIC));
    shapes.map(function(shape) {
      //body.shapes.add(shape);
      shape.body = body;
      shape.material = material;
    });
  }

  public static function ball(x : Float, y : Float, radius : Float, material : Material, ?type : BodyType) {
    var body = new Structure([new Circle(radius)], material, type);
    body.body.position.setxy(x, y);
    return body;
  }

  public static function rect(x : Float, y : Float, width : Float, height : Float, material : Material, ?type : BodyType)
    return new Structure([new Polygon(Polygon.rect(x, y, width, height))], material, type);

  public static function perimeter(x : Float, y : Float, width : Float, height : Float, size : Float, material : Material) {
    return new Structure([
      new Polygon(Polygon.rect(x, y, width, size)),
      new Polygon(Polygon.rect(x + width - size, y + size, width, height - size * 2)),
      new Polygon(Polygon.rect(x, y + height - size, width, size)),
      new Polygon(Polygon.rect(x, size, size, height - size * 2))
    ], material, BodyType.STATIC);
  }
}
