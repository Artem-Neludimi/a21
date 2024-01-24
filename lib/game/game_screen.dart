import 'dart:math';

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

  //boot state
  bool _isTap = false;

  //ball state

  @override
  Future<void> onLoad() async {
    addAll([
      BackGround(),
      _ball = BallSprite(),
      _boot = BootSprite(),
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
    _provideBootPosition(info.eventPosition.global);
    super.onPanUpdate(info);
  }

  @override
  void onPanEnd(DragEndInfo info) {
    _isTap = false;
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

class BackGround extends SpriteComponent with HasGameRef<MyGame> {
  BackGround() : super(priority: 0);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(
      'bg_1.png',
      srcPosition: Vector2(50, 50),
    );
    add(ScreenHitbox());
  }
}

class BallSprite extends SpriteComponent with HasGameRef<MyGame>, CollisionCallbacks {
  BallSprite() : super(priority: 1);

  @override
  Future<void> onLoad() async {
    final ball = await gameRef.loadSprite('ball.png');
    size = Vector2(100, 100);
    position = Vector2(
      gameRef.size.x / 2 - 50,
      gameRef.size.y / 1.7 - 50,
    );
    sprite = ball;
    add(CircleHitbox(radius: 100));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is BootSprite) {
      print('collision with boot');
    }
    if (other is ScreenHitbox) {
      print('collision with screen');
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
    add(RectangleHitbox(
      size: Vector2(157, 100),
    ));
  }
}
