import 'package:flutter/material.dart';
import 'package:myoro_fitness/widgets/buttons/button_without_feedback.dart';

/// [Icon] pre-wrapped in [ButtonWithoutFeedback]
class IconButtonWithoutFeedback extends StatelessWidget {
  /// onTap for [ButtonWithoutFeedback]
  final Function onTap;

  /// Size of the icon
  final double size;

  /// The icon within the [Icon]
  final IconData icon;

  const IconButtonWithoutFeedback({
    super.key,
    required this.onTap,
    required this.icon,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) => ButtonWithoutFeedback(
        onTap: () => onTap(),
        child: Icon(
          icon,
          size: size,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      );
}
