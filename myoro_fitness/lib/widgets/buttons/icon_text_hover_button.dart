import 'package:flutter/material.dart';

/// Hover button that can contain a text, an icon, or both
class IconTextHoverButton extends StatelessWidget {
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

  /// If [IconTextHoverButton] is wrapped with an expanded
  final bool expanded;

  /// If [IconTextHoverButton] has a border or not
  final bool bordered;

  IconTextHoverButton({
    super.key,
    required this.onTap,
    this.icon,
    this.iconSize = 40,
    this.text,
    this.textStyle,
    this.expanded = false,
    this.bordered = false,
  }) {
    assert(icon != null || text != null);
  }

  @override
  Widget build(BuildContext context) => expanded ? Expanded(child: _widget()) : _widget();

  Widget _widget() => _Widget(
        onTap: onTap,
        icon: icon,
        iconSize: iconSize,
        text: text,
        textStyle: textStyle,
        bordered: bordered,
      );
}

class _Widget extends StatefulWidget {
  final Function onTap;
  final IconData? icon;
  final double iconSize;
  final String? text;
  final TextStyle? textStyle;
  final bool bordered;

  const _Widget({
    required this.onTap,
    this.icon,
    this.iconSize = 40,
    this.text,
    this.textStyle,
    this.bordered = false,
  });

  @override
  State<_Widget> createState() => _WidgetState();
}

class _WidgetState extends State<_Widget> {
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
            border: Border.all(
              width: 2,
              color: widget.bordered ? theme.colorScheme.onPrimary : Colors.transparent,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            child: Wrap(
              alignment: WrapAlignment.center,
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
