import 'package:a21/game/game.dart';
import 'package:a21/widgets.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final AppBloc _bloc;
  late final MyGame _game;

  @override
  void initState() {
    _bloc = context.read<AppBloc>();
    _game = MyGame(_bloc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppBloc>().state;
    return PopScope(
      canPop: false,
      child: Stack(
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
            ),
          ),
          const _Score(),
          Positioned(
            top: 100,
            right: 10,
            child: Column(
              children: [
                Icon(state.lives < 3 ? Icons.favorite_border : Icons.favorite, size: 50),
                Icon(state.lives < 2 ? Icons.favorite_border : Icons.favorite, size: 50),
                Icon(state.lives < 1 ? Icons.favorite_border : Icons.favorite, size: 50),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Score extends StatelessWidget {
  const _Score();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: SizedBox(
            height: 50,
            width: 150,
            child: Board(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Image.asset('assets/images/ball_icon.png'),
                  Expanded(
                    child: BlocBuilder<AppBloc, AppState>(
                      builder: (context, state) {
                        return TextWithShadow(
                          state.currentGameScore.toString(),
                          fontSize: 24,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
