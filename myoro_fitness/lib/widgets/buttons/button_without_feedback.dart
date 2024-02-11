import 'package:flutter/material.dart';

/// Button that accepts a widget
class ButtonWithoutFeedback extends StatelessWidget {
  /// onTap of [ButtonWithoutFeedback]
  final Function onTap;

  /// [Widget] of [ButtonWithoutFeedback]
  final Widget child;

  /// [Tooltip] message of [ButtonWithoutFeedback]
  final String tooltip;

  const ButtonWithoutFeedback({
    super.key,
    required this.onTap,
    required this.child,
    this.tooltip = '',
  });

  @override
  Widget build(BuildContext context) => Tooltip(
        message: tooltip,
        child: InkWell(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => onTap(),
          child: child,
        ),
      );
}
