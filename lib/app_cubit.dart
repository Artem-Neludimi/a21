import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(
          AppState(
            nickName: '',
            score: 0,
            currentGameScore: 0,
            leaderBoard: [
              for (int i = 0; i < 99; i++)
                (
                  'PLAYER#${generatePlayerRandomNumber()}',
                  generateScoreRandomNumber(),
                ),
            ],
          ),
        );

  void setNickName(String nickName) {
    String name = nickName;
    if (name.isEmpty) {
      name = 'PLAYER#${generatePlayerRandomNumber()}';
    }
    emit(state.copyWith(nickName: name));
  }

  void addScore(int score) {
    emit(state.copyWith(score: state.score + score));
  }
}

class AppState {
  const AppState({
    required this.nickName,
    required this.score,
    required this.currentGameScore,
    required this.leaderBoard,
  });

  final String nickName;
  final int score;
  final int currentGameScore;
  final List<(String, int)> leaderBoard;

  List<(String, int)> get sortedLeaderBoard {
    final sorted = [...leaderBoard, (nickName, score)];
    sorted.sort((a, b) => b.$2.compareTo(a.$2));
    return sorted;
  }

  AppState copyWith({
    String? nickName,
    int? score,
    int? currentGameScore,
    List<(String, int)>? leaderBoard,
  }) {
    return AppState(
      nickName: nickName ?? this.nickName,
      score: score ?? this.score,
      currentGameScore: currentGameScore ?? this.currentGameScore,
      leaderBoard: leaderBoard ?? this.leaderBoard,
    );
  }
}

int generatePlayerRandomNumber() {
  final randomNumber = Random().nextInt(900000) + 100000;
  return randomNumber;
}

int generateScoreRandomNumber() {
  final randomNumber = Random().nextInt(1000);
  return randomNumber;
}
