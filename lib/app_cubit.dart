import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'main.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(
          AppState(
            nickName: '',
            score: prefs.getInt('score') ?? 0,
            currentGameScore: 0,
            leaderBoard: [
              for (int i = 0; i < 99; i++)
                (
                  'PLAYER#${generatePlayerRandomNumber()}',
                  generateScoreRandomNumber(),
                ),
            ],
            addedLive: prefs.getInt('addedLive') ?? 0,
            scoreMultipliers: prefs.getInt('scoreMultipliers') ?? 0,
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
    prefs.setInt('score', state.score + score);
  }

  void subtractLive() {
    emit(state.copyWith(addedLive: state.addedLive - 1));
    prefs.setInt('addedLive', state.addedLive - 1);
  }
}

class AppState {
  const AppState({
    required this.nickName,
    required this.score,
    required this.currentGameScore,
    required this.leaderBoard,
    required this.addedLive,
    required this.scoreMultipliers,
  });

  final String nickName;
  final int score;
  final int currentGameScore;
  final List<(String, int)> leaderBoard;
  final int addedLive;
  final int scoreMultipliers;

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
    int? addedLive,
    int? scoreMultipliers,
  }) {
    return AppState(
      nickName: nickName ?? this.nickName,
      score: score ?? this.score,
      currentGameScore: currentGameScore ?? this.currentGameScore,
      leaderBoard: leaderBoard ?? this.leaderBoard,
      addedLive: addedLive ?? this.addedLive,
      scoreMultipliers: scoreMultipliers ?? this.scoreMultipliers,
    );
  }
}

int generatePlayerRandomNumber() {
  final randomNumber = Random().nextInt(900000) + 100000;
  return randomNumber;
}

int generateScoreRandomNumber() {
  final randomNumber = Random().nextInt(9000) + 1000;
  return randomNumber;
}
