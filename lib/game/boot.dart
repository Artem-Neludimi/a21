import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'game.dart';

class BootSprite extends SpriteComponent with HasGameRef<MyGame>, CollisionCallbacks {
  BootSprite() : super(priority: 1);

  @override
  Future<void> onLoad() async {
    final boot = await gameRef.loadSprite('boot_1.png');
    size = Vector2(157, 100);
    position = Vector2(
      gameRef.size.x / 2 - 50,
      gameRef.size.y / 1.7 - 50,
    );
    sprite = boot;
    position = Vector2(
      gameRef.size.x / 2.5 - 50,
      gameRef.size.y / 1.2 - 50,
    );
    add(PolygonHitbox([
      Vector2(0, 60),
      Vector2(0, size.y),
      Vector2(size.x - 20, size.y - 20),
      Vector2(size.x - 40, 0),
    ]));
  }

  @override
  void update(double dt) {
    if (game.isTap && angle <= 0) {
      angle += 0.025;
    } else if (!gameRef.isTap && angle >= -0.5) {
      angle -= 0.025;
    }

    super.update(dt);
  }
}
