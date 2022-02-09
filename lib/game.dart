import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';

class WallPasserGame extends FlameGame {
  final SpriteAnimationComponent darkSoldier = SpriteAnimationComponent(
    size: Vector2(130, 130),
    position: Vector2(130, 300),
  );

  @override
  Future<void>? onLoad() async {
    final spriteSheet = SpriteSheet(
      image: await Flame.images.load('darksoldier_spritesheet.png'),
      srcSize: Vector2(64, 64),
    );

    darkSoldier.animation = spriteSheet.createAnimation(row: 1, stepTime: 0.1);

    add(darkSoldier);

    return super.onLoad();
  }
}
