import 'package:a21/game/background.dart';
import 'package:a21/game/timer.dart';
import 'package:a21/main.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'ball.dart';
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
