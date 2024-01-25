import 'dart:math';

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
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is BootSprite) {
      speed = 1200;
      direction.y = other.position.y > position.y ? 3 : -1;
      direction.x = other.position.x < position.x ? 1 : -1;
      if (gameRef.isTap && gameRef.isStarted && other.position.y > 300) {
        gameRef.bloc.add(GameHit());
      }
    }
    if (other is ScreenHitbox) {
      final random = Random();
      speed = 900;
      direction.y = other.position.y < position.y ? random.nextDouble() : -random.nextDouble();
      direction.x = other.position.x < position.x ? random.nextDouble() : -random.nextDouble();
    }

    super.onCollision(intersectionPoints, other);
  }
}
