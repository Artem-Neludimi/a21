import 'package:a21/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      prefs = await SharedPreferences.getInstance();
      final firstTime = prefs.getBool('firstTime');
      if (firstTime == null) {
        await prefs.setBool('firstTime', true);
      } else {
        await prefs.setBool('firstTime', false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: switch (state) {
                MenuState.splash => const Splash(
                    key: ValueKey(MenuState.splash),
                  ),
              },
            );
          },
        ),
      ),
    );
  }
}


class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuState.splash);
}

enum MenuState {
  splash,
}
