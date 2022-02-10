import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';

import './player.dart';

class WallPasserGame extends FlameGame with HasTappables, HasDraggables {
  late Player _player;

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
      position: Vector2(150, 150),
      size: Vector2(100, 100),
      anchor: Anchor.center,
      joystick: joystick,
    );
    add(_player);

    return super.onLoad();
  }
}
