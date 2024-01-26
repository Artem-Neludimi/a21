import 'package:a21/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppButton(
              onTap: () => Navigator.of(context).pushNamed('/game'),
              text: 'START',
            ),
            const SizedBox(height: 24),
            AppButton(
              text: 'SHOP',
              onTap: () => context.read<MenuCubit>().toShop(),
            ),
            const SizedBox(height: 24),
            AppButton(
              onTap: () => context.read<MenuCubit>().toSettings(),
              text: 'SETTINGS',
            ),
            const SizedBox(height: 24),
            AppButton(
              onTap: () => context.read<MenuCubit>().toRating(),
              text: 'RATING',
            ),
            const SizedBox(height: 24),
            AppButton(
              onTap: () => context.read<MenuCubit>().toHowToPlay(),
              text: 'HOW TO PLAY',
              height: 111,
            ),
          ],
        ),
      ),
    );
  }
}
