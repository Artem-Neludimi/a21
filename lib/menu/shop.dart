import 'package:a21/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets.dart';
import 'home.dart';

class ShopCubit extends Cubit<(String?, int?)> {
  ShopCubit() : super((null, null));
  setItem(String? image, int? price) => emit((image, price));
}

class _ShopProvider extends StatelessWidget {
  const _ShopProvider({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(),
      child: child,
    );
  }
}

class Shop extends StatelessWidget {
  const Shop({super.key});

  @override
  Widget build(BuildContext context) {
    final appCubit = context.watch<AppCubit>();
    return _ShopProvider(
      child: Builder(builder: (context) {
        final shopState = context.watch<ShopCubit>().state;
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
                      child: shopState.$1 == null
                          ? Column(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Board(
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: const [
                                        _BGItem('assets/images/bg_1.png', 0),
                                        _BGItem('assets/images/bg_2.png', 1000),
                                        _BGItem('assets/images/bg_3.png', 1500),
                                        _BGItem('assets/images/bg_4.png', 2000),
                                        _BGItem('assets/images/bg_5.png', 3000),
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
                                        _BallItem('assets/images/ball_1.png', 0),
                                        _BallItem('assets/images/ball_2.png', 1000),
                                        _BallItem('assets/images/ball_3.png', 1500),
                                        _BallItem('assets/images/ball_4.png', 2000),
                                        _BallItem('assets/images/ball_5.png', 3000),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Expanded(
                                  flex: 2,
                                  child: Board(
                                    padding: const EdgeInsets.all(4),
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: const [
                                        _BootImage(image: 'assets/images/boot_1.png', price: 0),
                                        _BootImage(image: 'assets/images/boot_2.png', price: 1000),
                                        _BootImage(image: 'assets/images/boot_3.png', price: 1500),
                                        _BootImage(image: 'assets/images/boot_4.png', price: 2000),
                                        _BootImage(image: 'assets/images/boot_5.png', price: 3000),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Expanded(
                                  flex: 2,
                                  child: Board(
                                    padding: const EdgeInsets.all(4),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              appCubit.buyLive();
                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/images/added_live.png',
                                                  height: 40,
                                                ),
                                                Text(
                                                  appCubit.state.addedLive.toString(),
                                                  style: const TextStyle(fontSize: 24),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              appCubit.buyMultiplier();
                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/images/double.png',
                                                  height: 40,
                                                ),
                                                Text(
                                                  appCubit.state.scoreMultipliers.toString(),
                                                  style: const TextStyle(fontSize: 24),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.asset(shopState.$1!),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/ball_golden_icon.png',
                                      height: 55,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      shopState.$2.toString(),
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                AppButton(
                                  onTap: () {
                                    if (appCubit.state.score < shopState.$2!) return;
                                    appCubit.buyItem(shopState.$1!, shopState.$2!);
                                    context.read<ShopCubit>().setItem(null, null);
                                  },
                                  text: 'BUY',
                                )
                              ],
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _BootImage extends StatelessWidget {
  const _BootImage({
    required this.image,
    required this.price,
  });

  final String image;
  final int price;

  @override
  Widget build(BuildContext context) {
    final use = context.watch<AppCubit>().state.bootImage == image;
    final contains = context.watch<AppCubit>().state.allBoughtItems.contains(image);

    return GestureDetector(
      onTap: () {
        if (contains) {
          context.read<AppCubit>().setBootImage(image);
          return;
        }
        context.read<ShopCubit>().setItem(image, price);
      },
      child: Stack(
        children: [
          Padding(
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
          if (contains)
            Positioned(
              child: Image.asset(
                'assets/images/star.png',
                height: 40,
              ),
            ),
        ],
      ),
    );
  }
}

class _BallItem extends StatelessWidget {
  const _BallItem(this.image, this.price);
  final String image;
  final int price;
  @override
  Widget build(BuildContext context) {
    final ballImage = context.watch<AppCubit>().state.ballImage;
    final contains = context.watch<AppCubit>().state.allBoughtItems.contains(image);

    return GestureDetector(
      onTap: () {
        if (contains) {
          context.read<AppCubit>().setBallImage(image);
          return;
        }
        context.read<ShopCubit>().setItem(image, price);
      },
      child: Stack(
        children: [
          Padding(
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
          if (contains)
            Positioned(
              child: Image.asset(
                'assets/images/star.png',
                height: 40,
              ),
            ),
        ],
      ),
    );
  }
}

class _BGItem extends StatelessWidget {
  const _BGItem(this.image, this.price);

  final String image;
  final int price;

  @override
  Widget build(BuildContext context) {
    final bgImage = context.watch<AppCubit>().state.bgImage;
    final contains = context.watch<AppCubit>().state.allBoughtItems.contains(image);
    return GestureDetector(
      onTap: () {
        if (contains) {
          context.read<AppCubit>().setBgImage(image);
          return;
        }
        context.read<ShopCubit>().setItem(image, price);
      },
      child: Stack(
        children: [
          Padding(
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
          if (contains)
            Positioned(
              child: Image.asset(
                'assets/images/star.png',
                height: 40,
              ),
            ),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onTap: () {
        if (context.read<ShopCubit>().state.$1 != null) {
          context.read<ShopCubit>().setItem(null, null);
          return;
        }
        context.read<MenuCubit>().tryGoToMenu();
      },
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
