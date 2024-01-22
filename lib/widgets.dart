import 'package:flutter/material.dart';

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
    this.color = Colors.white,
    this.shadowColor = Colors.black,
  });
  final String text;
  final double? fontSize;
  final Color color;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w600,
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
