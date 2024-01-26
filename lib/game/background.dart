import 'package:a21/game/game.dart';
import 'package:flame/components.dart';

class BackGround extends SpriteComponent with HasGameRef<MyGame> {
  BackGround() : super(priority: 0);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(
      gameRef.backgroundImage.substring(14),
      srcPosition: Vector2(50, 50),
      srcSize: Vector2(gameRef.size.x, gameRef.size.y),
    );
    add(ScreenHitbox());
    super.onLoad();
  }
}
