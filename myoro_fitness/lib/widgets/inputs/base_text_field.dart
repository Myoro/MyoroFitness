import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myoro_fitness/enums/size_enum.dart';

/// [Widget] for all [TextField] in the application
class BaseTextField extends StatelessWidget {
  /// [Size] of [BaseTextField]
  final SizeEnum size;

  /// (Optional) width of [TextField]
  final double? width;

  /// (Optional) [TextField] input formatters
  final List<TextInputFormatter> formatters;

  /// Function triggered when [TextField] is changed
  final Function(String)? onChanged;

  /// Controller of [TextField]
  final TextEditingController? controller;

  const BaseTextField({
    super.key,
    required this.size,
    this.width,
    this.formatters = const [],
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final UnderlineInputBorder border = UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
    late final TextStyle textStyle;
    late final double height;

    switch (size) {
      case SizeEnum.small:
        textStyle = theme.textTheme.bodySmall!;
        height = 30;
        break;
      case SizeEnum.medium:
        textStyle = theme.textTheme.bodyMedium!;
        height = 40;
        break;
      case SizeEnum.large:
        textStyle = theme.textTheme.bodyLarge!;
        height = 50;
        break;
    }

    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        onChanged: (value) => onChanged != null ? onChanged!(value) : {},
        controller: controller,
        inputFormatters: formatters,
        style: textStyle,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          focusedBorder: border,
          enabledBorder: border,
          contentPadding: const EdgeInsets.only(bottom: 5),
        ),
      ),
    );
  }
}
