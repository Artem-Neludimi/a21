import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
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

class MyGame extends FlameGame {
  MyGame();

  late BallSprite ball;
  late BootSprite boot;

  @override
  Future<void> onLoad() async {
    addAll([
      BackGround(),
      ball = BallSprite(),
      boot = BootSprite(),
    ]);
  }
}

class BackGround extends SpriteComponent {
  BackGround() : super(priority: 0);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(
      'bg_1.png',
      srcPosition: Vector2(50, 50),
    );
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
  }

  @override
  void update(double dt) {
    position -= Vector2(0, -1) * dt * 300;
    super.update(dt);
  }
}

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
    angle = -0.5;
  }
}
