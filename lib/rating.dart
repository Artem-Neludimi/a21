import 'package:a21/home.dart';
import 'package:a21/main.dart';
import 'package:a21/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/gradient_borders.dart';

class Rating extends StatelessWidget {
  const Rating({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16).copyWith(top: 0),
        child: const Column(
          children: [
            _BackButton(),
            SizedBox(height: 16),
            _Title(),
            SizedBox(height: 16),
            _Board(),
          ],
        ),
      ),
    );
  }
}

class _Board extends StatefulWidget {
  const _Board({
    super.key,
  });

  @override
  State<_Board> createState() => _BoardState();
}

class _BoardState extends State<_Board> {
  bool loading = true;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Board(
              border: const GradientBoxBorder(
                width: 10,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(241, 218, 122, 1),
                    Color.fromRGBO(219, 192, 98, 1),
                  ],
                ),
              ),
              child: loading
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : ListView.separated(
                      itemCount: state.sortedLeaderBoard.length + 1,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        index -= 1;
                        if (index < 0) {
                          return const SizedBox(
                            height: 65,
                            child: Board(
                              padding: EdgeInsets.all(6),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: _Text('RANK'),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      child: _Text('NAME'),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: _Text('SCORES'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return SizedBox(
                          height: 65,
                          child: Board(
                            border: state.nickName == state.sortedLeaderBoard[index].$1
                                ? const GradientBoxBorder(
                                    width: 2,
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color.fromRGBO(241, 218, 122, 1),
                                        Color.fromRGBO(219, 192, 98, 1),
                                      ],
                                    ),
                                  )
                                : null,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: _Text('#${index + 1}'),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            const SizedBox(width: double.infinity, height: double.infinity),
                                            Positioned(
                                              top: -10,
                                              bottom: -10,
                                              child: Image.asset(
                                                state.nickName == state.sortedLeaderBoard[index].$1
                                                    ? 'assets/images/user_golden.png'
                                                    : 'assets/images/user_green.png',
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: FittedBox(
                                    child: _Text(state.sortedLeaderBoard[index].$1),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: _Text(
                                      state.sortedLeaderBoard[index].$2.toString(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        );
      },
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/images/medal.png'),
        const SizedBox(width: 3),
        const TextWithShadow(
          'LEADERBOARD',
          fontSize: 30,
        ),
        const SizedBox(width: 3),
        Image.asset('assets/images/medal.png'),
      ],
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        width: 70,
        height: 70,
        child: AppButton(
          onTap: () => context.read<MenuCubit>().tryGoToMenu(),
          text: '',
          width: 70,
          height: 70,
          child: Image.asset('assets/images/back.png'),
        ),
      ),
    );
  }
}

class _Text extends StatelessWidget {
  const _Text(
    this.text,
  );
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 15,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );
  }
}
