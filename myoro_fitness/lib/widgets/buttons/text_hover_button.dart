import "package:flutter/material.dart";

class TextHoverButton extends StatefulWidget {
  final String title;
  final Function onTap;

  const TextHoverButton({ super.key, required this.title, required this.onTap });

  @override
  State<TextHoverButton> createState() => _TextHoverButtonState();
}

class _TextHoverButtonState extends State<TextHoverButton> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return InkWell(
      onTap: () => widget.onTap(),
      onHover: (hovered) => setState(() { this.hovered = hovered; }),
      splashColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:        hovered ? theme.colorScheme.onPrimary : null
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            widget.title,
            style: theme.textTheme.titleMedium!.copyWith(
              color: hovered ? theme.colorScheme.primary : theme.colorScheme.onPrimary
            )
          ),
        ),
      )
    );
  }
}