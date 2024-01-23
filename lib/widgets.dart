import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

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

class TextWithShadow extends StatelessWidget {
  const TextWithShadow(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight = FontWeight.w600,
    this.color = Colors.white,
    this.shadowColor = Colors.black,
  });
  final String text;
  final double? fontSize;
  final FontWeight fontWeight;
  final Color color;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        shadows: [
          Shadow(
            color: shadowColor,
            offset: const Offset(1, 3),
            blurRadius: 5,
          ),
        ],
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onTap,
    this.height = 75,
    this.width = 222,
    required this.text,
    this.child,
    this.fontSize = 33,
  });

  final VoidCallback? onTap;
  final double height;
  final double width;
  final String text;
  final Widget? child;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(51, 195, 159, 1),
              Color.fromRGBO(3, 122, 92, 1),
            ],
          ),
          border: GradientBoxBorder(
            width: 6,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(196, 255, 239, 1),
                Color.fromRGBO(0, 64, 46, 1),
              ],
            ),
          ),
        ),
        child: child ??
            Center(
              child: TextWithShadow(
                text,
                fontSize: fontSize,
              ),
            ),
      ),
    );
  }
}

class Board extends StatelessWidget {
  const Board({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border: const GradientBoxBorder(
              width: 3,
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(183, 183, 183, 0.32),
                  Color.fromRGBO(255, 255, 255, 0.5),
                  Color.fromRGBO(183, 183, 183, 0.32),
                ],
              ),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
