// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:math';

import 'package:a21/home.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'game/game_screen.dart';

late final SharedPreferences prefs;
final player = AudioPlayer();
bool isPlaying = false;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MenuCubit(),
        ),
        BlocProvider(
          create: (context) => AppBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.white,
            selectionColor: Colors.white,
            selectionHandleColor: Colors.white,
          ),
          colorScheme: const ColorScheme.dark().copyWith(),
          useMaterial3: true,
          fontFamily: 'Jost',
        ),
        routes: {
          '/': (context) => const MyHomePage(),
          '/game': (context) => const GameScreen(),
        },
      ),
    );
  }
}

sealed class AppEvent {}

class GameHit extends AppEvent {}

class GameBallFell extends AppEvent {}

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc()
      : super(
          AppState(
            nickName: '',
            leaderBoard: [
              for (int i = 0; i < 99; i++)
                (
                  'PLAYER#${generatePlayerRandomNumber()}',
                  generateScoreRandomNumber(),
                ),
            ],
            score: prefs.getInt('score') ?? 0,
            currentGameScore: 0,
            lives: 3,
          ),
        ) {
    on<AppEvent>(
      (event, emit) => switch (event) {
        GameHit() => _onHit(emit),
        GameBallFell() => _onBallFell(emit),
      },
      transformer: droppable(),
    );
  }

  void setNickName(String nickName) {
    String name = nickName;
    if (name.isEmpty) {
      name = 'PLAYER#${generatePlayerRandomNumber()}';
    }
    emit(state.copyWith(nickName: name));
  }

  void endGame() {
    emit(
      state.copyWith(
        currentGameScore: 0,
        lives: 3,
      ),
    );
  }

  Future<void> _onHit(Emitter<AppState> emit) async {
    emit(
      state.copyWith(
        currentGameScore: state.currentGameScore + 10,
        score: state.score + 10,
      ),
    );
    await prefs.setInt('score', state.score + 10);
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<void> _onBallFell(Emitter<AppState> emit) async {
    emit(
      state.copyWith(
        lives: state.lives - 1,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 500));
  }
}

class AppState {
  const AppState({
    required this.nickName,
    required this.leaderBoard,
    required this.score,
    required this.currentGameScore,
    required this.lives,
  });

  final String nickName;
  final List<(String, int)> leaderBoard;
  final int score;
  final int currentGameScore;
  final int lives;

  List<(String, int)> get sortedLeaderBoard {
    final sorted = [...leaderBoard, (nickName, score)];
    sorted.sort((a, b) => b.$2.compareTo(a.$2));
    return sorted;
  }

  AppState copyWith({
    String? nickName,
    List<(String, int)>? leaderBoard,
    int? score,
    int? currentGameScore,
    int? lives,
  }) {
    return AppState(
      nickName: nickName ?? this.nickName,
      leaderBoard: leaderBoard ?? this.leaderBoard,
      score: score ?? this.score,
      currentGameScore: currentGameScore ?? this.currentGameScore,
      lives: lives ?? this.lives,
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
