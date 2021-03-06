import pixi.core.renderers.SystemRenderer;
import pixi.core.renderers.Detector;
import ledge.Config;
import js.Browser;

class Main {
  static function main() {
		Config.init();

    var options : RenderingOptions = {
						antialias : Config.stage.antialias,
						autoResize : Config.stage.autoResize,
            resolution : Config.stage.resolution,
            backgroundColor : Config.stage.background
          },
        renderer = Detector.autoDetectRenderer(
          Config.stage.width,
          Config.stage.height,
          options);
    Browser.document.body.appendChild(renderer.view);
    new ledge.Game(renderer);
  }
}
