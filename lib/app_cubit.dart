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
            bgImage: prefs.getString('bgImage') ?? 'assets/images/bg_1.png',
            ballImage: prefs.getString('ballImage') ?? 'assets/images/ball_1.png',
            bootImage: prefs.getString('bootImage') ?? 'assets/images/boot_1.png',
            allBoughtItems: prefs.getStringList('allBoughtItems') ??
                [
                  'assets/images/bg_1.png',
                  'assets/images/ball_1.png',
                  'assets/images/boot_1.png',
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
    prefs.setInt('score', state.score + score);
    emit(state.copyWith(score: state.score + score));
  }

  void useLive() {
    prefs.setInt('addedLive', state.addedLive - 1);
    emit(state.copyWith(addedLive: state.addedLive - 1));
  }

  void useScoreMultipliers() {
    prefs.setInt('scoreMultipliers', state.scoreMultipliers - 1);
    emit(state.copyWith(scoreMultipliers: state.scoreMultipliers - 1));
  }

  void setBgImage(String image) {
    prefs.setString('bgImage', image);
    emit(state.copyWith(bgImage: image));
  }

  void setBallImage(String image) {
    prefs.setString('ballImage', image);
    emit(state.copyWith(ballImage: image));
  }

  void setBootImage(String image) {
    prefs.setString('bootImage', image);
    emit(state.copyWith(bootImage: image));
  }

  void buyItem(String s, int i) {
    final allBoughtItems = [...state.allBoughtItems, s];
    prefs.setStringList('allBoughtItems', allBoughtItems);
    emit(state.copyWith(allBoughtItems: allBoughtItems));
    addScore(-i);
  }

  void buyMultiplier() {
    if (state.score < 1000) return;
    emit(state.copyWith(scoreMultipliers: state.scoreMultipliers + 1));
    addScore(-1000);
  }

  void buyLive() {
    if (state.score < 1000) return;
    emit(state.copyWith(addedLive: state.addedLive + 1));
    addScore(-1000);
  }

  void addLive() {
    prefs.setInt('addedLive', state.addedLive + 1);
    emit(state.copyWith(addedLive: state.addedLive + 1));
  }

  void addScoreMultipliers() {
    prefs.setInt('scoreMultipliers', state.scoreMultipliers + 1);
    emit(state.copyWith(scoreMultipliers: state.scoreMultipliers + 1));
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
    required this.bgImage,
    required this.ballImage,
    required this.bootImage,
    required this.allBoughtItems,
  });

  final String nickName;
  final int score;
  final int currentGameScore;
  final List<(String, int)> leaderBoard;
  final int addedLive;
  final int scoreMultipliers;
  final String bgImage;
  final String ballImage;
  final String bootImage;
  final List<String> allBoughtItems;

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
    String? bgImage,
    String? ballImage,
    String? bootImage,
    List<String>? allBoughtItems,
  }) {
    return AppState(
      nickName: nickName ?? this.nickName,
      score: score ?? this.score,
      currentGameScore: currentGameScore ?? this.currentGameScore,
      leaderBoard: leaderBoard ?? this.leaderBoard,
      addedLive: addedLive ?? this.addedLive,
      scoreMultipliers: scoreMultipliers ?? this.scoreMultipliers,
      bgImage: bgImage ?? this.bgImage,
      ballImage: ballImage ?? this.ballImage,
      bootImage: bootImage ?? this.bootImage,
      allBoughtItems: allBoughtItems ?? this.allBoughtItems,
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
