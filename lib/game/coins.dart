import 'dart:math';

import 'package:flame/components.dart';

import 'game.dart';

class Coins extends SpriteComponent with HasGameRef<MyGame> {
  Coins() : super(priority: 10);

  @override
  Future<void> onLoad() async {
    final coins = await gameRef.loadSprite('coins.png');
    size = Vector2(gameRef.size.x, 300);
    position = Vector2(0, -300);
    sprite = coins;
  }

  @override
  void update(double dt) {
    //gravity
    position -= Vector2(0, -1) * dt * 400;
    opacity = max(opacity - 0.015, 0);

    super.update(dt);
  }
}
