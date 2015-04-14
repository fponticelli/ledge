package ledge;

class Config implements thx.core.StaticResource {
  public static function init() {
    Config.stage.resolution = js.Browser.window.devicePixelRatio;
  }
}
