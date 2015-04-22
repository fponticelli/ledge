package ledge;

class Config implements thx.StaticResource {
  public static function init() {
    Config.stage.resolution = js.Browser.window.devicePixelRatio;
  }
}
