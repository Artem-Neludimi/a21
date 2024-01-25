// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:a21/main.dart';
import 'package:a21/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/gradient_borders.dart';

import 'home.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;
            return Column(
              children: [
                Center(
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: height * 0.85,
                    padding: const EdgeInsets.all(44),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/onboarding.png'),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            border: const GradientBoxBorder(
                              width: 3,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromRGBO(222, 221, 211, 1),
                                  Color.fromRGBO(209, 200, 163, 1),
                                ],
                              ),
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            'Control the ball with the cleat, do feints, earn coins',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
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
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                AppButton(
                  onTap: () async {
                    await prefs.setBool('firstTime', false);
                    context.read<MenuCubit>().tryGoToMenu();
                  },
                  text: 'NEXT',
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
