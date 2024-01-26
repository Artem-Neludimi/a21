// ignore_for_file: use_build_context_synchronously

import 'package:a21/main.dart';
import 'package:a21/menu/home.dart';
import 'package:a21/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_cubit.dart';

class Bonus extends StatefulWidget {
  const Bonus({super.key});

  @override
  State<Bonus> createState() => _BonusState();
}

class _BonusState extends State<Bonus> {
  late int bonusesRewarded;
  @override
  void initState() {
    bonusesRewarded = prefs.getInt('bonusesRewarded') ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            child: Board(
              child: Row(
                children: [
                  _DayItem(
                    text: 'DAY 1',
                    isCurrentDay: bonusesRewarded == 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TextWithShadow('+50'),
                        Image.asset('assets/images/ball_golden_icon.png'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 3),
                  _DayItem(
                    text: 'DAY 2',
                    isCurrentDay: bonusesRewarded == 1,
                    child: Image.asset('assets/images/added_live.png'),
                  ),
                  const SizedBox(width: 3),
                  _DayItem(
                    text: 'DAY 3',
                    isCurrentDay: bonusesRewarded == 2,
                    child: Image.asset('assets/images/double.png'),
                  ),
                  const SizedBox(width: 3),
                  _DayItem(
                    text: 'DAY 4',
                    isCurrentDay: bonusesRewarded == 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TextWithShadow('+200'),
                        Image.asset('assets/images/ball_golden_icon.png'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 3),
                  _DayItem(
                    text: 'DAY 5',
                    isCurrentDay: bonusesRewarded == 4,
                    child: Image.asset('assets/images/ball_3.png'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          AppButton(
            onTap: () async {
              if (bonusesRewarded == 0) {
                await prefs.setInt('bonusesRewarded', 1);
                context.read<AppCubit>().addScore(50);
              } else if (bonusesRewarded == 1) {
                await prefs.setInt('bonusesRewarded', 2);
                context.read<AppCubit>().addLive();
              } else if (bonusesRewarded == 2) {
                await prefs.setInt('bonusesRewarded', 3);
                context.read<AppCubit>().addScoreMultipliers();
              } else if (bonusesRewarded == 3) {
                await prefs.setInt('bonusesRewarded', 4);
                context.read<AppCubit>().addScore(200);
              } else if (bonusesRewarded == 4) {
                await prefs.setInt('bonusesRewarded', 5);
                context.read<AppCubit>().buyItem('assets/images/ball_3.png', 0);
              }

              context.read<MenuCubit>().tryGoToMenu();
            },
            text: 'RECEIVE',
          ),
        ],
      ),
    );
  }
}

class _DayItem extends StatelessWidget {
  const _DayItem({
    required this.child,
    required this.text,
    required this.isCurrentDay,
  });
  final Widget child;
  final String text;
  final bool isCurrentDay;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isCurrentDay) Image.asset('assets/images/pointer.png', height: 50) else const SizedBox(height: 50),
          Expanded(
            child: Board(
              padding: const EdgeInsets.all(2),
              child: child,
            ),
          ),
          TextWithShadow(text)
        ],
      ),
    );
  }
}
