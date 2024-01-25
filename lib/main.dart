import 'dart:math';

import 'package:a21/home.dart';
import 'package:audioplayers/audioplayers.dart';
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
          create: (context) => AppCubit(),
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

  void simpleHit() {
    emit(
      state.copyWith(
        score: state.score + 10,
        currentGameScore: state.currentGameScore + 10,
      ),
    );
  }

  void endGame() {
    emit(
      state.copyWith(
        currentGameScore: 0,
      ),
    );
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
