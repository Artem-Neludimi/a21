import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../main.dart';
import 'boot.dart';
import 'game.dart';

class BallSprite extends SpriteComponent with HasGameRef<MyGame>, CollisionCallbacks {
  BallSprite() : super(priority: 1);

  double speed = 0;
  Vector2 direction = Vector2.zero();

  @override
  Future<void> onLoad() async {
    final ball = await gameRef.loadSprite('ball.png');
    size = Vector2(100, 100);
    position = Vector2(
      gameRef.size.x / 2 - 50,
      gameRef.size.y / 1.5 - 50,
    );
    sprite = ball;
    add(CircleHitbox(
      radius: 50,
    ));
  }

  @override
  void update(double dt) {
    if (gameRef.isStarted == false) return;
    //gravity
    position -= Vector2(0, -1) * dt * 450;

    position -= direction * speed * dt;
    if (speed > 0) {
      speed -= 20;
      // angle -= 0.001;
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is BootSprite) {
      speed = 1200;
      direction.y = other.position.y > position.y ? 1 : -1;
      direction.x = other.position.x < position.x ? 1 : -1;
      if (gameRef.isTap && gameRef.isStarted) {
        gameRef.bloc.add(GameHit());
      }
    }
    if (other is ScreenHitbox) {
      speed = 900;
      direction.y = other.position.y < position.y ? 1 : -3;
      direction.x = other.position.x < position.x ? 1 : -1;
    }

    super.onCollision(intersectionPoints, other);
  }
}
