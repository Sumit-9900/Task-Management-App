import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TwoText extends StatelessWidget {
  final String text1;
  final String text2;
  final Widget screen;
  const TwoText({
    super.key,
    required this.text1,
    required this.text2,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text1,
        style: TextStyle(color: Colors.black, fontSize: 16),
        children: [
          TextSpan(
            text: text2,
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w500,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap =
                      () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => screen),
                      ),
          ),
        ],
      ),
    );
  }
}
