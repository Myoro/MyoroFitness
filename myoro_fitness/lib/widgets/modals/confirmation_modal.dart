import "package:flutter/material.dart";
import "package:myoro_fitness/widgets/buttons/button_without_feedback.dart";
import "package:myoro_fitness/widgets/buttons/text_hover_button.dart";

class ConfirmationModal extends StatelessWidget {
  final String title;
  final String message;
  final Function onYes;
  final Function? onNo;

  const ConfirmationModal({
    super.key,
    required this.title,
    required this.message,
    required this.onYes,
    this.onNo
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.all(20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: theme.textTheme.titleLarge),
              ButtonWithoutFeedback(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 0),
                  child: Image.asset(
                    "assets/img/Close${(theme.brightness == Brightness.dark) ? 'Dark' : 'Light'}.png",
                    width:  20,
                    height: 20
                  ),
                )
              )
            ]
          ),
          Text(
            message,
            style: theme.textTheme.titleMedium
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextHoverButton(
                title: "Yes",
                onTap: onYes
              ),
              const SizedBox(width: 10),
              TextHoverButton(
                title: "No",
                onTap: () {
                  if(onNo != null) onNo!();
                  Navigator.pop(context);
                }
              )
            ]
          )
        ]
      ),
    );
  }
}