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
            _Score(appCubit: appCubit),
            Positioned(
              top: 100,
              bottom: 0,
              left: 0,
              right: 0,
              child: Board(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Board(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const [
                              _BGItem('assets/images/bg_1.png'),
                              _BGItem('assets/images/bg_2.png'),
                              _BGItem('assets/images/bg_3.png'),
                              _BGItem('assets/images/bg_4.png'),
                              _BGItem('assets/images/bg_5.png'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        flex: 2,
                        child: Board(
                          padding: const EdgeInsets.all(4).copyWith(top: 8),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const [
                              _BallItem('assets/images/ball_1.png'),
                              _BallItem('assets/images/ball_2.png'),
                              _BallItem('assets/images/ball_3.png'),
                              _BallItem('assets/images/ball_4.png'),
                              _BallItem('assets/images/ball_5.png'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        flex: 2,
                        child: Board(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const [
                              _BootImage(image: 'assets/images/boot_1.png'),
                              _BootImage(image: 'assets/images/boot_2.png'),
                              _BootImage(image: 'assets/images/boot_3.png'),
                              _BootImage(image: 'assets/images/boot_4.png'),
                              _BootImage(image: 'assets/images/boot_5.png'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        flex: 2,
                        child: Board(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const [],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BootImage extends StatelessWidget {
  const _BootImage({
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    final use = context.watch<AppCubit>().state.bootImage == image;

    return GestureDetector(
      onTap: () => context.read<AppCubit>().setBootImage(image),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(image),
              ),
            ),
            Text(use ? 'use' : '', style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}

class _BallItem extends StatelessWidget {
  const _BallItem(this.image);
  final String image;
  @override
  Widget build(BuildContext context) {
    final ballImage = context.watch<AppCubit>().state.ballImage;
    return GestureDetector(
      onTap: () {
        context.read<AppCubit>().setBallImage(image);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(image),
              ),
            ),
            Text(ballImage == image ? 'use' : '', style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}

class _BGItem extends StatelessWidget {
  const _BGItem(this.image);

  final String image;

  @override
  Widget build(BuildContext context) {
    final bgImage = context.watch<AppCubit>().state.bgImage;
    return GestureDetector(
      onTap: () => context.read<AppCubit>().setBgImage(image),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  image,
                ),
              ),
            ),
            Text(bgImage == image ? 'use' : '', style: const TextStyle(fontSize: 24)),
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
