import 'package:flutter/material.dart';
import 'package:myoro_fitness/enums/size_enum.dart';
import 'package:myoro_fitness/widgets/inputs/base_text_field.dart';

/// A [Text] and [BaseTextField]
class BasicTextFieldForm extends StatelessWidget {
  /// Size of [BasicTextFieldForm]
  final SizeEnum size;

  /// Title of [BasicTextFieldForm]
  final String title;

  /// Width of [BaseTextField]
  final double? textFieldWidth;

  /// (Optional) tooltip of [BasicTextFieldForm]
  final String? tooltip;

  /// [TextEditingController] for [BaseTextField]
  final TextEditingController controller;

  const BasicTextFieldForm({
    super.key,
    required this.size,
    required this.title,
    required this.controller,
    this.textFieldWidth,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    late final TextStyle textStyle;

    switch (size) {
      case SizeEnum.small:
        textStyle = theme.textTheme.bodySmall!;
        break;
      case SizeEnum.medium:
        textStyle = theme.textTheme.bodyMedium!;
        break;
      case SizeEnum.large:
        textStyle = theme.textTheme.bodyLarge!;
        break;
    }

    return Row(
      // spacing: 10,
      // crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$title:', style: textStyle),
              if (tooltip != null) ...[
                const SizedBox(width: 10),
                Tooltip(
                  message: tooltip ?? '',
                  child: Icon(
                    Icons.help,
                    size: 20,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: 10),
        BaseTextField(
          size: size,
          width: textFieldWidth,
          controller: controller,
        ),
      ],
    );
  }
}
