import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget widget;
  const ActionButton({
    super.key,
    required this.onPressed,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 40,
      child: ElevatedButton(onPressed: onPressed, child: widget),
    );
  }
}
