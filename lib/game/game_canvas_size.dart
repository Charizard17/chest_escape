import 'package:flame/components.dart';

mixin GameCanvasSize on Component {
  late Vector2 gameCanvasSize;

  @override
  void onGameResize(Vector2 newGameSize) {
    gameCanvasSize = Vector2(newGameSize.x, newGameSize.y - 250);
    super.onGameResize(newGameSize);
  }
}
