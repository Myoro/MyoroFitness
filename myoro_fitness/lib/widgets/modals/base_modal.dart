import 'package:flutter/material.dart';
import 'package:myoro_fitness/widgets/buttons/button_without_feedback.dart';
import 'package:myoro_fitness/widgets/buttons/icon_text_hover_button.dart';

/// [Widget] used to make all cards in the application
///
/// Always use [showDialog] within the [BaseModal] derivitive
class BaseModal extends StatelessWidget {
  /// [Size] of [BaseModal]
  final Size size;

  /// Title of [BaseModal]
  final String? title;

  /// Whether to show the positive and negative button in the footer
  final bool showFooterButtons;

  /// Text of the positive (yes) button
  final String yesText;

  /// onTap of positive (yes) button
  final Function? yesOnTap;

  /// Main body of [BaseModal]
  final Widget content;

  BaseModal({
    super.key,
    required this.content,
    this.size = const Size(300, 300),
    this.title,
    this.showFooterButtons = false,
    this.yesText = 'Confirm',
    this.yesOnTap,
  }) {
    if (showFooterButtons) {
      assert(showFooterButtons && yesOnTap != null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Center(
      child: Material(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: theme.colorScheme.onPrimary,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    if (title != null)
                      Text(
                        title!,
                        style: theme.textTheme.titleMedium,
                      ),
                    const Spacer(),
                    ButtonWithoutFeedback(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close,
                        size: 26,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
                content,
                if (showFooterButtons) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      IconTextHoverButton(
                        onTap: () => yesOnTap!(),
                        text: yesText,
                        expanded: true,
                        bordered: true,
                      ),
                      const SizedBox(width: 10),
                      IconTextHoverButton(
                        onTap: () => Navigator.pop(context),
                        text: 'Cancel',
                        expanded: true,
                        bordered: true,
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
