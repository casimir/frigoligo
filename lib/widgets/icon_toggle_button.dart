import 'package:flutter/material.dart';

class IconToggleButton extends StatelessWidget {
  const IconToggleButton({
    super.key,
    required this.isSelected,
    required this.onPressed,
    required this.icon,
  });

  final bool isSelected;
  final void Function()? onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? IconButton.filledTonal(onPressed: onPressed, icon: icon)
        : IconButton(onPressed: onPressed, icon: icon);
  }
}
