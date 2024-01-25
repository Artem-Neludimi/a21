import 'package:a21/game/game_screen.dart';
import 'package:flame/components.dart';

class BackGround extends SpriteComponent with HasGameRef<MyGame> {
  BackGround() : super(priority: 0);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(
      'bg_1.png',
      srcPosition: Vector2(50, 50),
      srcSize: Vector2(gameRef.size.x, gameRef.size.y),
    );
    add(ScreenHitbox());
    super.onLoad();
  }
}
