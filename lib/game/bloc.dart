// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

sealed class GameEvent {}

class GameHit extends GameEvent {}

class GameBallFall extends GameEvent {}

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc()
      : super(
          const GameState(
            score: 0,
            lives: 3,
            isWin: false,
            isLose: false,
          ),
        ) {
    on<GameEvent>(
      (event, emit) {
        return switch (event) {
          GameHit() => _onHit(emit),
          GameBallFall() => _onBallFall(emit),
        };
      },
      transformer: droppable(),
    );
  }
  Future<void> _onHit(Emitter<GameState> emit) async {
    emit(state.copyWith(score: state.score + 10));
    if (state.score > 1000) {
      emit(state.copyWith(isWin: true));
    }
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<void> _onBallFall(Emitter<GameState> emit) async {
    emit(state.copyWith(lives: state.lives - 1));
    if (state.lives == 0) {
      emit(state.copyWith(isLose: true));
    }
    await Future.delayed(const Duration(milliseconds: 600));
  }
}

class GameState {
  const GameState({
    required this.score,
    required this.lives,
    required this.isWin,
    required this.isLose,
  });
  final int score;
  final int lives;
  final bool isWin;
  final bool isLose;

  GameState copyWith({
    int? score,
    int? lives,
    bool? isWin,
    bool? isLose,
  }) {
    return GameState(
      score: score ?? this.score,
      lives: lives ?? this.lives,
      isWin: isWin ?? this.isWin,
      isLose: isLose ?? this.isLose,
    );
  }
}
