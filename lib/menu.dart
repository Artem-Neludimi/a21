import 'package:a21/widgets.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppButton(text: 'START'),
            SizedBox(height: 24),
            AppButton(text: 'SHOP'),
            SizedBox(height: 24),
            AppButton(text: 'SETTINGS'),
            SizedBox(height: 24),
            AppButton(text: 'RATING'),
            SizedBox(height: 24),
            AppButton(
              text: 'HOW TO PLAY',
              height: 111,
            ),
          ],
        ),
      ),
    );
  }
}
