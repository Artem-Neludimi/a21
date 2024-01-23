import 'dart:math';
import 'dart:developer' as developer;

import 'package:a21/bonus.dart';
import 'package:a21/main.dart';
import 'package:a21/nickname.dart';
import 'package:a21/onborading.dart';
import 'package:a21/setings.dart';
import 'package:a21/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_redirect/store_redirect.dart';

import 'menu.dart';
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
      final firstTime = prefs.getBool('firstTime') ?? true;
      if (firstTime) {
        await prefs.setBool('firstTime', true);

        Random random = Random();
        int delay = random.nextInt(30) + 30;
        Future.delayed(Duration(seconds: delay), () {
          developer.log('Redirecting to app store');
          StoreRedirect.redirect(iOSAppId: ""); //TODO: Replace with app id
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        return Stack(
          children: [
            Image.asset(
              'assets/images/splash_bg.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Image.asset(
              state == MenuState.splash ? 'assets/images/splash_bg.png' : 'assets/images/menu_bg.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            FootStands(width: width),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                child: switch (state) {
                  MenuState.splash => const Splash(
                      key: ValueKey(MenuState.splash),
                    ),
                  MenuState.userName => const Nickname(
                      key: ValueKey(MenuState.userName),
                    ),
                  MenuState.menu => const Menu(
                      key: ValueKey(MenuState.menu),
                    ),
                  MenuState.onboarding => const Onboarding(
                      key: ValueKey(MenuState.onboarding),
                    ),
                  MenuState.bonus => const Bonus(
                      key: ValueKey(MenuState.bonus),
                    ),
                  MenuState.settings => const Settings(
                      key: ValueKey(MenuState.settings),
                    ),
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuState.splash);

  void toUserName(MenuState state) => emit(MenuState.userName);

  void tryGoToMenu() {
    final firstTime = prefs.getBool('firstTime')!;
    if (firstTime) {
      emit(MenuState.onboarding);
    } else {
      emit(MenuState.menu);
    }
  }

  void toOnboarding() => emit(MenuState.onboarding);

  void toSettings() => emit(MenuState.settings);
}

enum MenuState {
  splash,
  userName,
  menu,
  onboarding,
  bonus,
  settings,
}
