import 'package:flutter/material.dart';
import 'package:myoro_fitness/enums/size_enum.dart';

/// Basic value: A [Row] with two [Text] widgets
class BasicOutput extends StatelessWidget {
  /// Font sizes for [BasicOutput]
  final SizeEnum size;

  /// Title of [BasicOutput]
  final String title;

  /// Width of title
  final double? titleWidth;

  /// Output message of [BasicOutput]
  final String value;

  /// Width of value
  final double? valueWidth;

  const BasicOutput({
    super.key,
    required this.size,
    required this.title,
    required this.value,
    this.titleWidth,
    this.valueWidth,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    late final TextStyle titleStyle;
    late final TextStyle valueStyle;

    switch (size) {
      case SizeEnum.small:
        titleStyle = textTheme.titleSmall!;
        valueStyle = textTheme.bodySmall!;
        break;
      case SizeEnum.medium:
        titleStyle = textTheme.titleMedium!;
        valueStyle = textTheme.bodyMedium!;
        break;
      case SizeEnum.large:
        titleStyle = textTheme.titleLarge!;
        valueStyle = textTheme.bodyLarge!;
        break;
    }

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SizedBox(
          width: titleWidth,
          child: Text(
            title,
            style: titleStyle,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: valueWidth,
          child: Text(
            value,
            style: valueStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
