import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

sealed class GameEvent {}

class GameHit extends GameEvent {}

class GameBallFall extends GameEvent {}

class GameRestart extends GameEvent {}

class GameAddLive extends GameEvent {}

class GameMultiplyScore extends GameEvent {}

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc()
      : super(
          const GameState(
            score: 0,
            lives: 3,
            isWin: false,
            isLose: false,
            multipliedScore: false,
          ),
        ) {
    on<GameEvent>(
      (event, emit) {
        return switch (event) {
          GameHit() => _onHit(emit),
          GameBallFall() => _onBallFall(emit),
          GameRestart() => _onRestart(emit),
          GameAddLive() => _onAddedLive(emit),
          GameMultiplyScore() => _onMultiplyScore(emit),
        };
      },
      transformer: droppable(),
    );
  }

  Future<void> _onHit(Emitter<GameState> emit) async {
    emit(state.copyWith(score: state.score + 10));
    if (state.score >= 1000) {
      emit(state.copyWith(isWin: true));
    }
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<void> _onBallFall(Emitter<GameState> emit) async {
    emit(state.copyWith(lives: state.lives - 1));
    if (state.lives <= 0) {
      emit(state.copyWith(isLose: true));
    }
    await Future.delayed(const Duration(milliseconds: 600));
  }

  Future<void> _onRestart(Emitter<GameState> emit) async {
    emit(const GameState(
      score: 0,
      lives: 3,
      isWin: false,
      isLose: false,
      multipliedScore: false,
    ));
  }

  Future<void> _onAddedLive(Emitter<GameState> emit) async {
    emit(state.copyWith(
      isLose: false,
      lives: state.lives + 1,
    ));
  }

  Future<void> _onMultiplyScore(Emitter<GameState> emit) async {
    emit(state.copyWith(
      score: state.score * 2,
      multipliedScore: true,
    ));
  }
}

class GameState {
  const GameState({
    required this.score,
    required this.lives,
    required this.isWin,
    required this.isLose,
    required this.multipliedScore,
  });
  final int score;
  final int lives;
  final bool isWin;
  final bool isLose;
  final bool multipliedScore;

  bool get isInitial => score == 0 && lives == 3 && isWin == false && isLose == false && multipliedScore == false;

  GameState copyWith({
    int? score,
    int? lives,
    bool? isWin,
    bool? isLose,
    bool? multipliedScore,
  }) {
    return GameState(
      score: score ?? this.score,
      lives: lives ?? this.lives,
      isWin: isWin ?? this.isWin,
      isLose: isLose ?? this.isLose,
      multipliedScore: multipliedScore ?? this.multipliedScore,
    );
  }
}
