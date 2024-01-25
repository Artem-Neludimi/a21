import 'dart:ui';

import 'package:a21/main.dart';
import 'package:a21/home.dart';
import 'package:a21/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/gradient_borders.dart';

class Nickname extends StatefulWidget {
  const Nickname({
    super.key,
  });

  @override
  State<Nickname> createState() => _NicknameState();
}

class _NicknameState extends State<Nickname> {
  final _controller = TextEditingController();
  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextWithShadow(
            'USER NAME:',
            fontSize: 33,
          ),
          const SizedBox(height: 16),
          _Field(controller: _controller),
          const SizedBox(height: 80),
          AppButton(
            text: 'NEXT',
            onTap: () {
              context.read<AppBloc>().setNickName(_controller.text);
              context.read<MenuCubit>().tryGoToMenu();
            },
          )
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: double.infinity,
          height: 88,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: const GradientBoxBorder(
              width: 4,
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(75, 123, 134, 1),
                  Color.fromRGBO(153, 191, 176, 1),
                  Color.fromRGBO(75, 123, 134, 1),
                ],
              ),
            ),
            color: Colors.white.withOpacity(0.1),
          ),
          child: TextField(
            controller: _controller,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 33,
              shadows: [
                Shadow(
                  color: Colors.black,
                  offset: Offset(1, 3),
                  blurRadius: 5,
                ),
              ],
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 33,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(1, 3),
                    blurRadius: 5,
                  ),
                ],
              ),
              hintText: 'Name',
            ),
          ),
        ),
      ),
    );
  }
}
