import 'package:a21/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets.dart';
import 'home.dart';

class Shop extends StatelessWidget {
  const Shop({super.key});

  @override
  Widget build(BuildContext context) {
    final appCubit = context.watch<AppCubit>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16).copyWith(top: 0),
        child: Stack(
          children: [
            const SizedBox(height: double.infinity, width: double.infinity),
            const _BackButton(),
            _Score(appCubit: appCubit)
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onTap: () => context.read<MenuCubit>().tryGoToMenu(),
      text: '',
      width: 70,
      height: 70,
      child: Image.asset('assets/images/back.png'),
    );
  }
}

class _Score extends StatelessWidget {
  const _Score({
    required this.appCubit,
  });

  final AppCubit appCubit;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: 50,
            child: Board(
              padding: const EdgeInsets.only(left: 25),
              child: TextWithShadow(
                appCubit.state.score.toString(),
                fontSize: 33,
              ),
            ),
          ),
          Positioned(
            left: -30,
            top: -5,
            bottom: -12.5,
            child: Image.asset(
              'assets/images/ball_golden_icon.png',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
