import 'package:a21/game/background.dart';
import 'package:a21/game/timer.dart';
import 'package:a21/main.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'boot.dart';

class MyGame extends FlameGame with PanDetector, HasCollisionDetection {
  final AppBloc bloc;
  MyGame(this.bloc);

  late BootSprite boot;
  late BallSprite ball;

  //game state
  bool isStarted = false;

  //boot state
  bool isTap = false;

  @override
  Future<void> onLoad() async {
    addAll([
      BackGround(),
      ball = BallSprite(),
      boot = BootSprite(),
      TimerText(),
    ]);
    super.onLoad();
  }

  @override
  void onPanStart(DragStartInfo info) {
    _provideBootPosition(info.eventPosition.global);
    isTap = true;
    super.onPanStart(info);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    _provideBootPosition(info.eventPosition.global);
    super.onPanUpdate(info);
  }

  @override
  void onPanEnd(DragEndInfo info) {
    isTap = false;
    super.onPanEnd(info);
  }

  //boot methods -----------------------------
  void _provideBootPosition(Vector2 position) {
    boot.position = Vector2(
      position.x - boot.size.x / 2 + 50,
      position.y - boot.size.y / 2 + 50,
    );
  }
}

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
      speed -= 25;
      // angle -= 0.001;
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is BootSprite) {
      speed = 1200;
      direction.y = 2;
      direction.x = other.position.x < position.x ? 1 : -1;
      if (gameRef.isTap && gameRef.isStarted) {
        gameRef.bloc.add(GameHit());
      }
    }
    if (other is ScreenHitbox) {
      speed = 900;
      direction.y = other.position.y < position.y ? 1 : -1;
      direction.x = other.position.x < position.x ? 1 : -1;
    }

    super.onCollision(intersectionPoints, other);
  }
}
