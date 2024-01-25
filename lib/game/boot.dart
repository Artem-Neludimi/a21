import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'ball.dart';
import 'game.dart';

class BootSprite extends SpriteComponent with HasGameRef<MyGame>, CollisionCallbacks {
  BootSprite() : super(priority: 1);

  bool isHitting = false;

  @override
  Future<void> onLoad() async {
    final boot = await gameRef.loadSprite('boot_1.png');
    size = Vector2(130, 90);
    position = Vector2(
      gameRef.size.x / 2 - 50,
      gameRef.size.y / 1.7 - 50,
    );
    sprite = boot;
    position = Vector2(
      gameRef.size.x / 2,
      gameRef.size.y / 1.2,
    );
    add(PolygonHitbox([
      Vector2(0, 60),
      Vector2(0, size.y),
      Vector2(size.x - 20, size.y - 20),
      Vector2(size.x - 40, 0),
    ]));

    angle = -0.5;
    super.onLoad();
  }

  @override
  void update(double dt) {
    if (game.isTap && gameRef.isGameOn && isHitting) {
      angle = min(angle + 0.25, 1);
      anchor = Anchor.center;
    }
    if (isHitting == false) {
      angle = max(angle - 0.25, 0.0);
      anchor = Anchor.center;
    }

    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) async {
    if (other is BallSprite) {
      isHitting = true;
      await Future.delayed(const Duration(milliseconds: 400));
      isHitting = false;
    }
    super.onCollision(intersectionPoints, other);
  }
}
