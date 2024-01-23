import 'dart:ui';

import 'package:a21/home.dart';
import 'package:a21/widgets.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16).copyWith(top: 0),
        child: Stack(
          children: [
            const SizedBox(height: double.infinity, width: double.infinity),
            AppButton(
              onTap: () => context.read<MenuCubit>().tryGoToMenu(),
              text: '',
              width: 70,
              height: 70,
              child: Image.asset('assets/images/back.png'),
            ),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _Board(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const _Music(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                          child: AppButton(
                            onTap: () {
                              launchUrl(
                                Uri.parse(
                                  'https://google.com',
                                ),
                              );
                            },
                            text: 'PRIVATE POLICY',
                            width: double.infinity,
                            fontSize: 26,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                          child: AppButton(
                            onTap: () {
                              launchUrl(
                                Uri.parse(
                                  'https://google.com',
                                ),
                              );
                            },
                            text: 'TERMS OF USE',
                            width: double.infinity,
                            fontSize: 26,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                          child: AppButton(
                            onTap: () {
                              Share.share(
                                'https://google.com',
                              );
                            },
                            text: 'SHARE APP',
                            width: double.infinity,
                            fontSize: 26,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Music extends StatefulWidget {
  const _Music();

  @override
  State<_Music> createState() => _MusicState();
}

class _MusicState extends State<_Music> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (isPlaying) {
          await player.pause();
          isPlaying = false;
          setState(() {});
          return;
        }
        isPlaying = true;
        setState(() {});
        await player.play(AssetSource('sounds/music.mp3'));
        await player.setReleaseMode(ReleaseMode.loop);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TextWithShadow('Music', fontSize: 30),
          Stack(
            clipBehavior: Clip.none,
            children: [
              const SizedBox(
                width: 50,
                height: 50,
                child: _Board(
                  child: SizedBox(),
                ),
              ),
              Positioned(
                top: -15,
                child: !isPlaying
                    ? const SizedBox.shrink()
                    : Icon(
                        Icons.check,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 15,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        size: 70,
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Board extends StatelessWidget {
  const _Board({
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
