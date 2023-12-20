import "package:flutter/material.dart";
import "package:myoro_fitness/widgets/buttons/button_without_feedback.dart";

class NavigationBarButton extends StatelessWidget {
  final Function onTap;
  final Widget child;
  final bool selected;

  const NavigationBarButton({
    super.key,
    required this.onTap,
    required this.child,
    required this.selected
  });

  @override
  Widget build(BuildContext context) {
    return ButtonWithoutFeedback(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: selected ? Theme.of(context).colorScheme.onPrimary : null,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: child
          ),
        ),
      )
    );
  }
}