import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';

import './player.dart';
import './wall.dart';

class WallPasserGame extends FlameGame with HasTappables, HasDraggables {
  late Player _player;
  late Wall _wall;

  @override
  Future<void>? onLoad() async {
    final joystick = JoystickComponent(
      knob: CircleComponent(
        radius: 24,
        paint: BasicPalette.white.withAlpha(100).paint(),
      ),
      background: CircleComponent(
        radius: 60,
        paint: BasicPalette.white.withAlpha(100).paint(),
      ),
      margin: const EdgeInsets.only(right: 50, bottom: 40),
    );
    add(joystick);

    _player = Player(
      position: Vector2(200, 400),
      size: Vector2(100, 100),
      anchor: Anchor.center,
      joystick: joystick,
    );
    add(_player);

    _wall = Wall(
      position: Vector2(150, 150),
      size: Vector2(50, 50),
      anchor: Anchor.center,
      canvasSize: canvasSize,
    );
    add(_wall);

    return super.onLoad();
  }
}
