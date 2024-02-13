import 'package:flutter/material.dart';

/// Widget used to create every card in the application
class BaseCard extends StatelessWidget {
  /// Title shown below content of [BaseCard]
  final String? title;

  /// Determines if [BaseCard]'s title will be centered
  final bool titleCentered;

  /// [Widget] displayed at the top right of [BaseCard]
  final Widget? extraAction;

  /// [Widget] of [BaseCard], the contents
  final Widget content;

  const BaseCard({
    super.key,
    required this.content,
    this.title,
    this.titleCentered = false,
    this.extraAction,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          children: [
            if (title != null || extraAction != null) ...[
              Row(
                mainAxisAlignment: titleCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
                children: [
                  if (title != null) Text(title!, style: theme.textTheme.titleLarge),
                  if (extraAction != null) ...[
                    const Spacer(),
                    extraAction!,
                  ],
                ],
              ),
              const SizedBox(height: 5),
            ],
            content,
          ],
        ),
      ),
    );
  }
}
