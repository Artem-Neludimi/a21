import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

sealed class GameEvent {}

class GameHit extends GameEvent {}

class GameBallFall extends GameEvent {}

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameState(score: 0, lives: 3)) {
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
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<void> _onBallFall(Emitter<GameState> emit) async {
    emit(state.copyWith(lives: state.lives - 1));
    await Future.delayed(const Duration(milliseconds: 600));
  }
}

class GameState {
  const GameState({
    required this.score,
    required this.lives,
  });
  final int score;
  final int lives;

  GameState copyWith({
    int? score,
    int? lives,
  }) {
    return GameState(
      score: score ?? this.score,
      lives: lives ?? this.lives,
    );
  }
}
