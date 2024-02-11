import 'package:flutter/material.dart';

/// Hover button that can contain a text, an icon, or both
class IconTextHoverButton extends StatefulWidget {
  /// Button onTap
  final Function onTap;

  /// Icon of [IconTextHoverButton]
  final IconData? icon;

  /// Size of icon
  final double iconSize;

  /// Text of [IconTextHoverButton]
  final String? text;

  /// [TextStyle] of text
  final TextStyle? textStyle;

  IconTextHoverButton({
    super.key,
    required this.onTap,
    this.icon,
    this.iconSize = 40,
    this.text,
    this.textStyle,
  }) {
    assert(icon != null || text != null);
  }

  @override
  State<IconTextHoverButton> createState() => _IconTextHoverButtonState();
}

class _IconTextHoverButtonState extends State<IconTextHoverButton> {
  final ValueNotifier<bool> _hovered = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _hovered.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle? textStyle = widget.textStyle ?? theme.textTheme.bodyMedium;

    return ValueListenableBuilder(
      valueListenable: _hovered,
      builder: (context, hovered, child) => InkWell(
        onTap: () => widget.onTap(),
        onHover: (value) => _hovered.value = value,
        hoverColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: !hovered ? Colors.transparent : theme.colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            child: Wrap(
              children: [
                if (widget.icon != null) ...[
                  Icon(
                    widget.icon,
                    size: widget.iconSize,
                    color: !hovered ? theme.colorScheme.onPrimary : theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 5),
                ],
                if (widget.text != null)
                  Text(
                    widget.text!,
                    style: textStyle!.copyWith(
                      color: !hovered ? theme.colorScheme.onPrimary : theme.colorScheme.primary,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
