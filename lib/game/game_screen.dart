import 'package:a21/game/background.dart';
import 'package:a21/game/timer.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final _game = MyGame();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GameWidget(game: _game),
        SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Image.asset(
              'assets/images/menu.png',
            ),
          ),
        )),
      ],
    );
  }
}

class MyGame extends FlameGame with PanDetector, HasCollisionDetection {
  MyGame();

  late BootSprite _boot;
  late BallSprite _ball;
  late TimerText _timer;

  //game state
  String time = '3';

  //boot state
  bool _isTap = false;
  Vector2 bootPosition = Vector2.zero();

  @override
  Future<void> onLoad() async {
    addAll([
      BackGround(),
      _ball = BallSprite(),
      _boot = BootSprite(),
      _timer = TimerText(),
    ]);
    _boot.angle = -0.5;
  }

  @override
  void update(double dt) {
    _manageFootAngle();
    _manageBallPosition(dt);
    super.update(dt);
  }

  @override
  void onPanStart(DragStartInfo info) {
    _provideBootPosition(info.eventPosition.global);
    _isTap = true;
    super.onPanStart(info);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    bootPosition = info.eventPosition.global;
    _provideBootPosition(info.eventPosition.global);
    super.onPanUpdate(info);
  }

  @override
  void onPanEnd(DragEndInfo info) {
    _isTap = false;
    bootPosition = Vector2.zero();
    super.onPanEnd(info);
  }

  //boot methods -----------------------------
  void _provideBootPosition(Vector2 position) {
    _boot.position = Vector2(
      position.x - _boot.size.x / 2,
      position.y - _boot.size.y / 2,
    );
  }

  void _manageFootAngle() {
    if (_isTap && _boot.angle <= 0) {
      _boot.angle += 0.025;
    } else if (!_isTap && _boot.angle >= -0.5) {
      _boot.angle -= 0.025;
    }
  }

  //ball methods -----------------------------
  void _manageBallPosition(double dt) {
    //gravity
    _ball.position -= Vector2(0, -1) * dt * 450;
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
    }
    if (other is ScreenHitbox) {
      speed = 900;
      direction.y = other.position.y < position.y ? 1 : -1;
      direction.x = other.position.x < position.x ? 1 : -1;
    }

    super.onCollision(intersectionPoints, other);
  }
}

class BootSprite extends SpriteComponent with HasGameRef<MyGame> {
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
    add(CircleHitbox(
      radius: 50,
    ));
  }
}
