import 'package:a21/main.dart';
import 'package:a21/nickname.dart';
import 'package:a21/widgets.dart';
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
      body: BlocBuilder<MenuCubit, MenuState>(
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: switch (state) {
                          MenuState.splash => const AssetImage('assets/images/splash_bg.png'),
                          _ => const AssetImage('assets/images/menu_bg.png'),
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  FootStands(width: width),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    child: switch (state) {
                      MenuState.splash => const Splash(
                          key: ValueKey(MenuState.splash),
                        ),
                      MenuState.userName => const Nickname(
                          key: ValueKey(MenuState.userName),
                        ),
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuState.splash);

  void toUserName(MenuState state) => emit(MenuState.userName);
}

enum MenuState {
  splash,
  userName,
}
