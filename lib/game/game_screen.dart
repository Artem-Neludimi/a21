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
        _Lives(state: state),
        if (state.isWin || state.isLose)
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  const Spacer(),
                  TextWithShadow(
                    'YOU ${state.isWin ? 'WIN' : 'LOSE'}',
                    fontSize: 50,
                  ),
                  const Spacer(),
                  AppButton(
                    text: 'TRY AGAIN',
                    onTap: () {
                      context.read<GameBloc>().add(GameRestart());
                    },
                  ),
                  const SizedBox(height: 24),
                  AppButton(
                    text: 'MENU',
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      context.read<GameBloc>().add(GameAddLive());
                      context.read<AppCubit>().subtractLive();
                    },
                    child: Board(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextWithShadow(
                                '+',
                                fontSize: 33,
                              ),
                              SizedBox(width: 3),
                              Icon(Icons.favorite, size: 50),
                            ],
                          ),
                          Positioned(
                            top: -15,
                            right: -15,
                            child: Container(
                              width: 33,
                              height: 33,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: FittedBox(
                                child: TextWithShadow(
                                  context.read<AppCubit>().state.addedLive.toString(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const _Score(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          )
        else
          const Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: _Score(),
          ),
        const _BackButton(),
      ],
    );
  }
}

class _Lives extends StatelessWidget {
  const _Lives({
    required this.state,
  });

  final GameState state;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      right: 10,
      child: Column(
        children: [
          Icon(state.lives < 3 ? Icons.favorite_border : Icons.favorite, size: 50),
          Icon(state.lives < 2 ? Icons.favorite_border : Icons.favorite, size: 50),
          Icon(state.lives < 1 ? Icons.favorite_border : Icons.favorite, size: 50),
        ],
      ),
    );
  }
}

class _Score extends StatelessWidget {
  const _Score();

  @override
  Widget build(BuildContext context) {
    return Material(
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
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Image.asset(
            'assets/images/menu.png',
          ),
        ),
      ),
    );
  }
}
