import 'dart:async';

import 'package:a21/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      return Stack(
        children: [
          const SizedBox(width: double.infinity, height: double.infinity),
          _Ball(width: width),
          FootStands(width: width),
        ],
      );
    });
  }
}

class _Ball extends StatefulWidget {
  const _Ball({
    required this.width,
  });

  final double width;

  @override
  State<_Ball> createState() => _BallState();
}

class _BallState extends State<_Ball> {
  Timer? _timer;
  double _angle = 0;
  @override
  void initState() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _angle += 0.05;
      });
      if (_timer!.tick == 20) {
        context.read<MenuCubit>().toUserName(MenuState.userName);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -widget.width * 0.3,
      left: -widget.width * 0.4,
      width: widget.width,
      height: widget.width,
      child: AnimatedRotation(
        duration: const Duration(milliseconds: 100),
        turns: _angle,
        child: Image.asset('assets/images/ball.png'),
      ),
    );
  }
}
