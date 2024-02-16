import "package:flutter/material.dart";

class ButtonWithoutFeedback extends StatelessWidget {
  final dynamic Function() onTap;
  final Widget child;

  const ButtonWithoutFeedback({
    super.key,
    required this.onTap,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: child
      ),
    );
  }
}