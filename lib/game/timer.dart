import 'package:a21/game/game_screen.dart';
import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

class TimerText extends TextComponent with HasGameRef<MyGame> {
  TimerText() : super(priority: 1);

  late DateTime _startTime;

  @override
  Future<void> onLoad() async {
    text = '3';
    textRenderer = textPaint;
    position = Vector2(
      gameRef.size.x / 2 - 15,
      gameRef.size.y / 2 - 50,
    );
    _startTime = DateTime.now();
    super.onLoad();
  }

  @override
  void update(double dt) {
    if (_startTime.difference(DateTime.now()).inSeconds == -1) {
      text = '2';
    } else if (_startTime.difference(DateTime.now()).inSeconds == -2) {
      text = '1';
    } else if (_startTime.difference(DateTime.now()).inSeconds == -3) {
      text = 'GO!';
      position = Vector2(
        gameRef.size.x / 2 - 50,
        gameRef.size.y / 2 - 50,
      );
    } else if (_startTime.difference(DateTime.now()).inSeconds == -4) {
      text = '';
    }
    super.update(dt);
  }

  TextPaint textPaint = TextPaint(
    style: const TextStyle(
      fontSize: 55,
      fontFamily: 'Jost',
      fontWeight: FontWeight.w600,
      shadows: [
        Shadow(
          color: Colors.black,
          offset: Offset(1, 3),
          blurRadius: 5,
        ),
      ],
    ),
  );
}
