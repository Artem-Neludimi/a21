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
    return GameWidget(game: _game);
  }
}

class MyGame extends FlameGame {
  MyGame();

  @override
  Future<void> onLoad() async {
    addAll([
      BackGround(),
    ]);
    // interval.onTick = () => add(BubblesGroup());
  }
}

class BackGround extends SpriteComponent {
  BackGround() : super(priority: 0);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(
      'bg_5.png',
      srcPosition: Vector2(50, 50),
    );
  }
}
