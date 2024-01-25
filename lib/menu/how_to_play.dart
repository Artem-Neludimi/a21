import 'package:a21/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home.dart';

class HowToPlay extends StatelessWidget {
  const HowToPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: LayoutBuilder(builder: (context, constraints) {
          final height = constraints.maxHeight;
          return Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: AppButton(
                  onTap: () {
                    context.read<MenuCubit>().tryGoToMenu();
                  },
                  text: '',
                  width: 70,
                  height: 70,
                  child: Image.asset('assets/images/back.png'),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: height * 0.8,
                width: double.infinity,
                child: Board(
                  child: Column(
                    children: [
                      Text(
                        'Control the ball with a cleat. +10 points are awarded for each hit of the ball.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 15,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Image.asset(
                          'assets/images/ball_and_foot.png',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Make feints, earn coins. +100 points are awarded for each feint. You can spend points in the store.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 15,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Image.asset(
                          'assets/images/ball_and_4_foots.png',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
