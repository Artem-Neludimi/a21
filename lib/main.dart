import 'dart:math';

import 'package:a21/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences prefs;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        },
      ),
    );
  }
}

class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(
          const AppState(
            nickName: '',
          ),
        );
  setNickName(String nickName) {
    String name = nickName;
    if (name.isEmpty) {
      final randomNumber = Random().nextInt(900000) + 100000;
      name = 'PLAYER#$randomNumber';
    }
    emit(state.copyWith(nickName: name));
  }
}

class AppState {
  const AppState({this.nickName});

  final String? nickName;

  AppState copyWith({
    String? nickName,
  }) {
    return AppState(
      nickName: nickName ?? this.nickName,
    );
  }
}
