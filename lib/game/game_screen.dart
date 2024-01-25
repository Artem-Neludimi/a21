import 'package:a21/app_cubit.dart';
import 'package:a21/game/bloc.dart';
import 'package:a21/game/game.dart';
import 'package:a21/widgets.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _GameConfig(
      child: _GamePresentation(),
    );
  }
}

class _GameConfig extends StatelessWidget {
  const _GameConfig({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(),
      child: BlocListener<GameBloc, GameState>(
        listenWhen: (previous, current) => current.isWin,
        listener: (context, state) {
          context.read<AppCubit>().addScore(state.score);
        },
        child: PopScope(
          canPop: false,
          child: child,
        ),
      ),
    );
  }
}

class _GamePresentation extends StatefulWidget {
  const _GamePresentation();
  @override
  State<_GamePresentation> createState() => _GamePresentationState();
}

class _GamePresentationState extends State<_GamePresentation> {
  late GameBloc _bloc;
  late MyGame _game;

  @override
  void initState() {
    _bloc = context.read<GameBloc>();
    _game = MyGame(_bloc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GameBloc>().state;

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
                    child: BlocBuilder<GameBloc, GameState>(
                      builder: (context, state) {
                        return TextWithShadow(
                          state.score.toString(),
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
