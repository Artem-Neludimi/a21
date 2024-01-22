import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      return Stack(
        children: [
          const SizedBox(width: double.infinity, height: double.infinity),
          FootStands(width: width),
        ],
      );
    });
  }
}

class FootStands extends StatelessWidget {
  const FootStands({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -100,
      left: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10000),
        child: Stack(
          children: [
            Container(
              width: width * 1.4,
              height: width * 1.4,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
            ),
            Positioned(
              bottom: 100,
              left: 0,
              child: Image.asset(
                'assets/images/foot_stands.png',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
