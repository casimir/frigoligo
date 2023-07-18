import 'package:flutter/material.dart';

class AsyncActionButton extends StatelessWidget {
  const AsyncActionButton({
    super.key,
    required this.icon,
    this.progressValue,
    required this.onPressed,
  });

  final Icon icon;
  final double? progressValue;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    if (progressValue == null) {
      return IconButton(icon: icon, onPressed: onPressed);
    }

    // TODO replace hardcoded eyeballed sizes with theme attributes
    var value = progressValue! > 0 ? progressValue! : null;
    return SizedBox(
      width: 40,
      height: 40,
      child: Center(
        child: SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(value: value),
        ),
      ),
    );
  }
}
