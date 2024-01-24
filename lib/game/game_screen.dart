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

class MyGame extends FlameGame with PanDetector {
  MyGame();

  late BootSprite _boot;
  late BallSprite _ball;

  //boot state
  bool _isTap = false;
  Vector2 _bootPosition = Vector2.zero();

  //ball state
  bool _toTop = false;
  final bool _toLeft = false;
  final bool _toRight = false;
  final double _bottomSpeed = 300;
  double _topSpeed = 300;
  final double _leftSpeed = 300;
  final double _rightSpeed = 300;

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
    _bootPosition = info.eventPosition.global;
    _provideBootPosition(info.eventPosition.global);
    super.onPanUpdate(info);
  }

  @override
  void onPanEnd(DragEndInfo info) {
    _isTap = false;
    _bootPosition = Vector2.zero();
    super.onPanEnd(info);
  }

  void _manageBallPosition(double dt) {
    if (_bootPosition.y > _ball.position.y &&
        _bootPosition.y < _ball.position.y + 100 &&
        _ball.position.x > _bootPosition.x - 150 &&
        _ball.position.x < _bootPosition.x + 50) {
      _ball.position.y = _bootPosition.y - 100;
      _setTopTrue();
    }
    _ballToBottom(dt);
    _ballToTop(dt);
    _ballToRight(dt);
    _ballToLeft(dt);
  }

  _ballToBottom(double dt) {
    final y = _ball.position.y;
    if (y <= size.y - _ball.size.y) {
      _ball.position -= Vector2(0, -1) * dt * _bottomSpeed;
    }
  }

  void _ballToTop(double dt) {
    if (_toTop == false) return;
    _ball.position -= Vector2(0, 1) * dt * _topSpeed;
  }

  void _ballToLeft(double dt) {
    if (_toLeft == false) return;
    if (_ball.position.x >= 0) {
      _ball.position -= Vector2(1, 0) * dt * _leftSpeed;
    }
  }

  void _ballToRight(double dt) {
    if (_toRight == false) return;
    if (_ball.position.x <= size.x - _ball.size.x) {
      _ball.position -= Vector2(-1, 0) * dt * _rightSpeed;
    }
  }

  void _provideBootPosition(Vector2 position) {
    _boot.position = Vector2(
      position.x - _boot.size.x / 2,
      position.y - _boot.size.y / 2,
    );
  }

  void _setTopTrue() async {
    _toTop = true;
    _topSpeed = 600;
    await Future.delayed(const Duration(milliseconds: 500));
    _toTop = false;
  }

  void _manageFootAngle() {
    if (_isTap && _boot.angle <= 0) {
      _boot.angle += 0.025;
    } else if (!_isTap && _boot.angle >= -0.5) {
      _boot.angle -= 0.025;
    }
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
    position = Vector2(
      gameRef.size.x / 2.5 - 50,
      gameRef.size.y / 1.2 - 50,
    );
  }
}
