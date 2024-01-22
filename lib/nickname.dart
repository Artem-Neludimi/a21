import 'package:a21/widgets.dart';
import 'package:flutter/material.dart';

class Nickname extends StatelessWidget {
  const Nickname({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWithShadow(
            'USER NAME:',
            fontSize: 33,
          ),
          SizedBox(height: 16),
          TextField(
            style: TextStyle(
              color: Colors.white,
              fontSize: 33,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 33,
              ),
              hintText: 'Name',
            ),
          ),
        ],
      ),
    );
  }
}
